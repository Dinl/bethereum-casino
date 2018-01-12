import React, { Component } from "react";
import { Link } from "react-router-dom";
import { connect } from "react-redux";

class HeaderBar extends Component {
	render() {
		return (
			<div>
				<header className="navbar m-2">
					<section className="navbar-section">
						<Link className="navbar-brand text-large mr-2" to="/">
							<i className="icon icon-message" /> Readable
						</Link>
					</section>
					<section className="navbar-section">

						<button
							className="btn btn-primary input-group-btn"
							onClick={() => this.props.openModal({ data: {} })}>
							<i className="icon icon-plus" /> Create Post
						</button>
					</section>
				</header>
			</div>
		);
	}
}

function mapStateToProps({ }) {
	return {
	};
}

function mapDispatchToProps(dispatch) {
	return {
	};
}
  
export default connect(mapStateToProps, mapDispatchToProps)(HeaderBar);
  