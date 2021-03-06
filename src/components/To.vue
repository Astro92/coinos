<template>
  <div>
    <v-form
      v-if="
        !payment.method ||
          ['bitcoin', 'liquid', 'lightning'].includes(payment.method)
      "
    >
      <v-textarea
        class="my-4"
        :label="label"
        v-model="to"
        auto-grow
        rows="1"
        @input="handleScan(to)"
        ref="to"
        :error="!!to && to.length > 0"
      >
        <template v-slot:append>
          <div v-if="to.length">
            <v-btn icon @click="showText(to)" class="ml-1" text>
              <qrcode />
            </v-btn>
          </div>

          <v-btn v-if="canPaste" class="mr-2 mb-2 flex-grow-1" @click="paste">
            <v-icon class="mr-1">assignment</v-icon>
            <span>Paste</span>
          </v-btn>
        </template>
      </v-textarea>
    </v-form>

    <methods v-if="!payment.method"/>
    <send-to-user v-if="payment.method === 'coinos'" />
    <paper v-if="payment.method === 'paper'" />
    <v-btn v-if="payment.method" @click="payment.method = null" class="mt-2 wide">
      <v-icon>arrow_back</v-icon>
      Back</v-btn
    >
  </div>
</template>

<script>
import { get, call, sync } from 'vuex-pathify';
import Copy from '../mixins/Copy';
import Qrcode from 'vue-material-design-icons/Qrcode';
import SendToUser from './SendToUser';
import Paper from './Paper';
import Methods from './Methods';

export default {
  components: { Paper, Qrcode, Methods, SendToUser },
  mixins: [Copy],
  data() {
    return {
      to: '',
    };
  },
  computed: {
    label() {
      return 'Paste an Address, Key, Invoice or URL';
    },
    canPaste: () => navigator.clipboard,
    payment: sync('payment'),
  },
  methods: {
    generate() {
      this.seed = generateMnemonic();
    },
    handleScan: call('handleScan'),
    showText: call('showText'),
    async paste() {
      this.to = await navigator.clipboard.readText();
      this.handleScan(this.to);
    },
  },
  mounted() {
    const vw = Math.max(
      document.documentElement.clientWidth,
      window.innerWidth || 0
    );
    if (vw > 600 && this.$refs.to) this.$refs.to.focus();
  },
};
</script>
