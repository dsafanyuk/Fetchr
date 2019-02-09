<template>
  <div class="text-xs-center">
    <v-dialog v-model="show" width="500">
      <v-card>
        <v-card-title
          class="headline justify-center text-xs-center font-weight-bold"
          primary-title
        >Refill your Wallet</v-card-title>
        <v-card-text>Your current balance is:</v-card-text>
        <v-card-text class="text-xs-center font-weight-medium display-3">${{walletBalance}}</v-card-text>
        <v-divider></v-divider>
        <v-card-actions class="justify-center text-xs-center" v-if="!transactionIsProcessing">
          <v-item-group class="text-xs-center" v-model="selectedAmount">
            <v-subheader>Select the amount to refill:</v-subheader>
            <v-item v-for="n in refillAmounts" :key="n">
              <v-chip slot-scope="{ active }" :selected="active" @click="selectAmount(n)">${{ n }}</v-chip>
            </v-item>
          </v-item-group>
        </v-card-actions>
        <div v-if="transactionIsProcessing">
          <v-progress-linear :indeterminate="true" height="15" color="success"></v-progress-linear>
        </div>
        <div v-else class="text-xs-center" @click="addToWallet">
          <v-btn :disabled="validAmountChosen" round color="success">Refill &nbsp; &nbsp;
            <v-icon>fas fa-money-bill-wave</v-icon>
          </v-btn>
        </div>
      </v-card>
    </v-dialog>
  </div>
</template>

<script>
import browserCookies from "browser-cookies";
import axios from "axios";

const api = axios.create();

export default {
  props: {
    value: Boolean,
    walletBalance: String
  },
  data() {
    return {
      refillAmounts: [5, 10, 15, 25],
      selectedAmount: null,
      transactionIsProcessing: false
    };
  },
  methods: {
    selectAmount(n) {
      this.selectedAmount = n;
    },
    addToWallet() {
      this.transactionIsProcessing = true;
      if (this.refillAmounts.includes(this.selectedAmount)) {
        console.log("true");
        api
          .post("/api/users/" + browserCookies.get("user_id") + "/wallet", {
            amount: this.selectedAmount
          })
          .then(response => {
            console.log(response.status);
            if (response.status == 200) {
              console.log("transaction successful");
            }
            this.transactionIsProcessing = false;
            this.$emit("updateWallet");
          })
          .catch(error => {
            if (error.response) {
              console.log(error.response.data);
              console.log(error.response.status);
              console.log(error.response.headers);
            } else if (error.request) {
              console.log(error.request);
            } else {
              // Something happened in setting up the request that triggered an Error
              console.log("Error", error.message);
            }
          });
      }
    }
  },
  computed: {
    show: {
      get() {
        console.log(`GET constructor ${this.value}`);
        return this.value;
      },
      set(value) {
        console.log(`set constructor ${value}`);

        this.$emit("input", value);
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

<style>
</style>
