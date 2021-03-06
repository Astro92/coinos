<template>
  <div>
    <v-expansion-panels accordion class="mb-2">
      <v-expansion-panel v-for="a in user.accounts" :key="a.asset">
        <v-expansion-panel-header ripple class="d-flex" expand-icon="">
          <div
            class="asset d-flex flex-grow-1"
            :class="{
              'body-1': $vuetify.breakpoint.xsOnly,
              title: !$vuetify.breakpoint.xs,
            }"
          >
            <div class="mb-1">
              {{ a.name }} <span class="yellow--text">({{ a.ticker }})</span>
            </div>
          </div>
          <div
            class="flex-grow-1 text-right"
            :class="{
              'body-1': $vuetify.breakpoint.xsOnly,
              'display-1': !$vuetify.breakpoint.xs,
            }"
          >
            {{ $format(a.balance, a.precision) }}
            <span
              v-if="a.pending"
              class="orange--text text--lighten-4"
              :class="{
                'body-1': $vuetify.breakpoint.xsOnly,
                title: !$vuetify.breakpoint.xs,
              }"
              >({{ $format(a.pending, a.precision) }} pending)</span
            >
          </div>
        </v-expansion-panel-header>
        <v-expansion-panel-content class="text-left">
          <div class="d-flex">
            <v-btn
              class="mx-auto mb-2 black--text"
              @click.prevent="() => select(a.asset)"
              color="yellow"
            >
              <v-icon>forward</v-icon>
              <span>Payments</span>
            </v-btn>
          </div>
          <v-card class="pa-4" style="background: #333">
            <v-alert
              v-if="success[a.asset]"
              class="mb-4"
              color="success"
              icon="info"
              v-model="success[a.asset]"
              dismissible
              transition="scale-transition"
              dark
            >
              Settings saved successfully
            </v-alert>
            <v-form @submit.prevent="() => submit(a)">
              <v-textarea
                label="Id"
                :value="a.asset"
                rows="1"
                auto-grow
                readonly
              >
                <template v-slot:append>
                  <v-btn @click="() => copy(a.asset)" icon class="ml-1">
                    <v-icon class="mr-1">content_copy</v-icon>
                  </v-btn>
                </template>
              </v-textarea>
              <v-text-field
                label="Name"
                v-model="a.name"
                rows="1"
                auto-grow
                :readonly="a.asset === BTC"
              />
              <v-text-field
                label="Ticker"
                v-model="a.ticker"
                rows="1"
                auto-grow
                :readonly="a.asset === BTC"
              />
              <v-text-field
                label="Precision"
                v-model="a.precision"
                type="number"
                @input="e => limit(e, a)"
                :readonly="a.asset === BTC"
              />
              <div class="text-right">
                <v-btn type="submit">
                  <v-icon class="mr-1 yellow--text">check</v-icon>
                  <span>save</span>
                </v-btn>
              </div>
            </v-form>
          </v-card>
        </v-expansion-panel-content>
      </v-expansion-panel>
    </v-expansion-panels>

    <v-btn
      class="mx-auto mb-2 black--text"
      @click="$go('/asset')"
      color="yellow"
    >
      <v-icon>add</v-icon>
      <span>New</span>
    </v-btn>
  </div>
</template>

<script>
import { get, sync, call } from 'vuex-pathify';
import Copy from '../mixins/Copy';
const BTC = process.env.VUE_APP_LBTC;

export default {
  mixins: [Copy],
  computed: {
    user: sync('user'),
  },
  data() {
    return {
      BTC,
      success: {},
    };
  },
  methods: {
    limit(e, a) {
      if (e < 0) this.$nextTick(() => (a.precision = 0));
      if (e > 8) this.$nextTick(() => (a.precision = 8));
    },
    async submit(a) {
      try {
        await this.updateAccount(a);
        this.$set(this.success, a.asset, true);
      } catch (e) {
        this.$set(this.success, a.asset, false);
      }
    },
    shiftAccount: call('shiftAccount'),
    updateAccount: call('updateAccount'),
    async select(a) {
      await this.shiftAccount(a);
      this.$go('/home');
    },
  },
};
</script>
<style lang="stylus" scoped>
.asset
  max-width 70%
  word-wrap break-word
</style>
