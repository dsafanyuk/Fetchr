<template>
  <v-footer height="auto" color="primary">
    <v-layout justify-center row wrap>
      <v-btn v-for="link in links" :key="link" color="white" flat round>{{ link }}</v-btn>
      <v-flex primary lighten-2 py-3 text-xs-center white--text xs12>
        &copy;2018 —
        <strong>Fetchr</strong>
      </v-flex>
    </v-layout>
  </v-footer>
</template>

<script>
export default {
  data: () => ({
    links: ["Home", "About Us", "Team", "Contact Us"]
  })
};
</script>


<style>
</style>
