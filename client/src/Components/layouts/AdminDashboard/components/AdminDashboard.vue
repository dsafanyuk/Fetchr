<template>
  <v-container fluid grid-list-lg>
    <v-layout row wrap align-center justify-space-around>
      <v-flex xs2 v-for="(card, i) in cards" :key="i">
        <v-card class="accent lighten--2">
          <v-container>
            <v-layout>
              <v-flex>
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
      <v-flex xs4>
        <v-card>
          <v-card-title>
            <span class="headline">Courier Quick Look</span>
          </v-card-title>
          <v-data-table :items="couriers" :headers="courierHeader" hide-actions class="elevation-1">
            <template slot="items" slot-scope="props">
              <td>{{ props.item.name }}</td>
              <td class="text-xs-right">{{ props.item.in_progress }}</td>
              <td class="text-xs-right">{{ props.item.delivered }}</td>
            </template>
          </v-data-table>
        </v-card>
      </v-flex>
      <v-flex xs5>
        <v-card>
          <v-card-title>
            <span class="headline">Recent Orders</span>
          </v-card-title>
          <apexchart
            type="bar"
            height="300"
            :options="chartOptions"
            :series="series"
            class="chart"
          />
        </v-card>
      </v-flex>
      <v-flex xs3>
        <v-card>
          <v-card-title>
            <span class="headline">Recent Orders</span>
          </v-card-title>
          <v-data-table :items="orders" hide-actions hide-headers class="elevation-1">
            <template slot="items" slot-scope="props">
              <td>{{ props.item.order }}</td>
              <td class="text-xs-right">{{ props.item.price }}</td>
            </template>
          </v-data-table>
        </v-card>
      </v-flex>
    </v-layout>
  </v-container>
</template>
<script>
export default {
  data() {
    return {
      series: [
        {
          data: [[1, 34], [3, 54], [5, 23], [15, 43]]
        }
      ],

      chartOptions: {
        xaxis: {},
        plotOptions: {
          bar: {
            horizontal: true
          }
        },
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
          floating: false,
          fontSize: "14px"
        },
        responsive: [
          {
            breakpoint: 480
          }
        ]
      },
      courierHeader: [
        { text: "Name", align: "left", value: "name" },
        { text: "In-Progress", align: "left", value: "in_progress" },
        { text: "Delivered", align: "left", value: "delivered" }
      ],
      cards: [
        { text: "Total Orders", icon: "shopping_basket", statValue: "1234" },
        { text: "Total Delivered", icon: "how_to_reg", statValue: "1234" },
        { text: "Total Users", icon: "group", statValue: "1234" },
        {
          text: "Total Amount Ordered",
          icon: "attach_money",
          statValue: "1234"
        }
      ],
      orders: [
        {
          order: "#154 - Dave Safanyuk",
          price: "$ 5.90"
        },
        {
          order: "#154 - Dave Safanyuk",
          price: "$ 5.90"
        },
        {
          order: "#154 - Dave Safanyuk",
          price: "$ 5.90"
        }
      ],
      couriers: [
        {
          name: "Dave Safanyuk",
          in_progress: "4",
          delivered: "2"
        },
        {
          name: "Dave Safanyuk",
          in_progress: "4",
          delivered: "2"
        },
        {
          name: "Dave Safanyuk",
          in_progress: "4",
          delivered: "2"
        }
      ]
    };
  }
};
</script>

<style>
.apexcharts-canvas {
  margin: 0 auto;
}
</style>
