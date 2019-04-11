<template>
  <div class="text-xs-center">
    <v-dialog v-model="show" width="500">
      <v-card>
        <div class="text-xs-right">
          <v-btn icon small color="gray " top @click="show = !show">
            <v-icon>clear</v-icon>
          </v-btn>
        </div>
        <v-card-title
          class="headline justify-center text-xs-center font-weight-bold"
          primary-title
        >Refill your Wallet</v-card-title>
        <v-card-text class="text-xs-center">Your current balance is:</v-card-text>
        <v-card-text class="text-xs-center font-weight-medium display-3">${{walletBalance}}</v-card-text>
        <v-divider></v-divider>
        <v-card-actions class="justify-center text-xs-center" v-if="!transactionIsProcessing">
          <v-item-group class="text-xs-center" v-model="selectedAmount">
            <v-subheader>Select the amount to refill:</v-subheader>
            <v-item v-for="n in refillAmounts" :key="n">
              <v-chip slot-scope="{ active }" :selected="active" @click="selectAmount(n)">${{ n }}</v-chip>
            </v-item>
            <v-item>
              <input
                v-if="otherChosen"
                autofocus
                slot-scope="{ active }"
                v-on:keypress="isNumber"
                :selected="active"
                placeholder="$"
                v-model="selectedAmount"
                class="otherAmount"
              >
              <v-chip v-else slot-scope="{ active }" :selected="active" @click="customAmount">other</v-chip>
            </v-item>
            <v-tooltip top>
              <template v-slot:activator="{ on }">
                <v-icon color="grey" dark v-on="on">info</v-icon>
              </template>
              <span>Your wallet balance cannot exceed $5000</span>
            </v-tooltip>
          </v-item-group>
        </v-card-actions>
        <div v-if="transactionIsProcessing">
          <v-progress-linear :indeterminate="true" height="15" color="success"></v-progress-linear>
        </div>
        <div v-else class="text-xs-center">
          <v-btn :disabled="validAmountChosen" round color="success" @click="addToWallet">
            Refill &nbsp; &nbsp;
            <v-icon>fas fa-money-bill-wave</v-icon>
          </v-btn>
        </div>
      </v-card>
    </v-dialog>
  </div>
</template>
  
  <script>
import browserCookies from "browser-cookies";
import axios from "../../../axios";
import { mapGetters } from "vuex";
import toasted from "vue-toasted";

export default {
  props: {
    value: Function
  },
  data() {
    return {
      refillAmounts: [5, 10, 15, 25],
      selectedAmount: null,
      transactionIsProcessing: false,
      otherChosen: false
    };
  },
  created: function() {
    this.$store.dispatch("wallet/getWalletBalance");
  },
  methods: {
    // so they cant type letters into the other amount field if we care about that kind of thing
    // from stack overflow
    isNumber: function(evt) {
      evt = evt ? evt : window.event;
      var charCode = evt.which ? evt.which : evt.keyCode;
      if (
        charCode > 31 &&
        (charCode < 48 || charCode > 57) &&
        charCode !== 46
      ) {
        evt.preventDefault();
      } else {
        return true;
      }
    },
    customAmount() {
      this.selectedAmount = null;
      this.otherChosen = true;
      //set focus
      setTimeout(() => {
        document.getElementsByClassName("otherAmount")[0].focus();
      }, 20);
    },
    selectAmount(n) {
      this.selectedAmount = n;
      this.otherChosen = false;
    },
    addToWallet() {
      this.transactionIsProcessing = true;
      this.selectedAmount = parseFloat(this.selectedAmount).toFixed(2);
      if (
        parseFloat(this.selectedAmount) + parseFloat(this.walletBalance) <=
        5000
      ) {
        axios
          .post("/api/users/" + browserCookies.get("user_id") + "/wallet", {
            amount: this.selectedAmount
          })
          .then(response => {
            if (response.status == 200) {
              this.$store.dispatch("wallet/getWalletBalance");
            }
            this.transactionIsProcessing = false;
            this.selectAmount(null);
          })
          .catch(error => {
            Vue.toasted.error("Failed wallet transaction", {
              theme: "bubble",
              duration: 4000,
              position: "top-center",
              icon: "report_problem"
            });
            console.log(error);
          });
      } else {
        this.$toasted
          .error(
            "Please enter a different amount that adds up to $5000"
          )
          .goAway(3000);
        this.transactionIsProcessing = false;
        this.selectAmount(null);
      }
    }
  },
  computed: {
    walletBalance: function() {
      return this.$store.getters["wallet/walletBalance"];
    },
    show: {
      get() {
        return this.$store.getters["wallet/walletIsActive"];
      },
      set(value) {
        this.$store.commit("wallet/toggleWallet", value);
      }
    },
    validAmountChosen() {
      if (!this.selectedAmount) {
        return true;
      } else return false;
    }
  }
};
</script>
  
  <style scoped>
.otherAmount {
  border-style: solid;
  display: inline-block;
  border-top: none;
  border-left: none;
  border-right: none;
  width: 62px;
  height: 32px;
  border-color: #e0e0e0;
  outline: none;
}
</style>
