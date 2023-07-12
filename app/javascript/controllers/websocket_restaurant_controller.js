import { Controller } from "@hotwired/stimulus"
import {createConsumer} from "@rails/actioncable"
export default class extends Controller {
  connect() {
    createConsumer().subscriptions.create({ channel: "RestaurantChannel", room: "33" })
  }


}
