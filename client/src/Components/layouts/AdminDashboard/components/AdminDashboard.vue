<template>
  <v-container fluid grid-list-lg>
    <v-layout row wrap align-center justify-space-around>
      <v-flex xs3 v-for="(card, i) in adminDashboard.cards" :key="i">
        <v-card class="accent lighten--2">
          <v-container>
            <v-layout>
              <v-flex xs2>
                <v-icon dark size="42">{{card.icon}}</v-icon>
              </v-flex>
              <v-flex text-lg-right class="white--text">
                <h1>{{card.statValue}}</h1>
                <span>{{card.text}}</span>
              </v-flex>
            </v-layout>
          </v-container>
        </v-card>
      </v-flex>
    </v-layout>
    <v-layout row wrap>
      <v-layout row wrap>
        <v-flex>
          <v-card class="leftCards">
            <v-card-title>
              <span class="headline">Courier Quick Look</span>
            </v-card-title>
            <v-data-table :items="adminDashboard.topCouriers" :headers="courierHeader" hide-actions class="elevation-1">
              <template slot="items" slot-scope="props">
                <td>{{ props.item.first_name }} {{ props.item.last_name}}</td>
                <td class="text-xs-right">{{ props.item.in_progress }}</td>
                <td class="text-xs-right">{{ props.item.delivered }}</td>
              </template>
            </v-data-table>
          </v-card>
          <v-card class="leftCards">
            <v-card-title>
              <span class="headline">Recent Orders</span>
            </v-card-title>
            <v-data-table :items="adminDashboard.recentOrders" hide-actions hide-headers class="elevation-1">
              <template slot="items" slot-scope="props">
                <td>{{ props.item.order_id }} - {{ props.item.first_name }} {{ props.item.last_name }}</td>
                <td class="text-xs-right">$ {{ props.item.order_total }}</td>
              </template>
            </v-data-table>
          </v-card>
        </v-flex>
      </v-layout>
      <v-flex xs5>
        <v-card>
          <v-card-title>
            <span class="headline">Products Sold by Category</span>
          </v-card-title>
          <apexchart
            type="pie"
            height="420"
            :options="chartOptions"
            :series="adminDashboard.counts"
            class="chart elevation-1"
          />
        </v-card>
      </v-flex>
    </v-layout>
  </v-container>
</template>
<script>
import axios from "../../../../axios";

export default {
  data() {
    return {
    };
  },
  created: function() {
    this.$store.dispatch('admin/getDashboard');
  },
  computed: {
    adminDashboard() {
      return this.$store.getters["admin/showDashboard"];
    },
    courierHeader() {
      let courierHeader = [
        { text: "Name", align: "center", value: "name" },
        { text: "In-Progress", align: "center", value: "in_progress" },
        { text: "Delivered", align: "center", value: "delivered" }
      ]
      return courierHeader;
    },
    chartOptions() {
      let chartOptions = {
        labels: this.adminDashboard.categories,
        chart: {
          id: "chart"
        },
        legend: {
          show: true,
          showForSingleSeries: false,
          showForNullSeries: true,
          showForZeroSeries: true,
          position: "bottom",
          horizontalAlign: "center",
          floating: true,
          fontSize: "14px"
        },
        responsive: [
          {
            breakpoint: 420
          }
        ]
      }
      return chartOptions;
    },
  },
};
</script>

<style>
.apexcharts-canvas {
  margin: 0 auto;
}
.leftCards {
  margin: 8px 7px 16.5px;
}
</style>
