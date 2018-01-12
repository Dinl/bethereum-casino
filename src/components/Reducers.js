import { combineReducers } from "redux";
import {

} from "./Actions";

function bets(state = { }, actionData) {
	switch (actionData.type) {
		default:
			return state;
	}
}

export default combineReducers({
	bets
});