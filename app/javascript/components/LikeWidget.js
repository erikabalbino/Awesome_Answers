import React, { Component } from "react";

class LikeWidget extends Component {
  constructor(props) {
    super(props);

    this.state = {
      likeId: props.likeId,
      likeCount: props.likeCount
    };

    this.toggleLike = this.toggleLike.bind(this);
  }

  toggleLike() {
    const { questionId } = this.props;
    const { likeId } = this.state;

    if (likeId) {
      fetch(`/api/v1/likes/${likeId}`, {
        method: "DELETE",
        credentials: "same-origin"
      })
        .then(res => res.json())
        .then(data =>
          this.setState({ likeId: undefined, likeCount: data.like_count })
        );
    } else {
      fetch(`/api/v1/questions/${questionId}/likes`, {
        method: "POST",
        credentials: "same-origin"
      })
        .then(res => res.json())
        .then(data =>
          this.setState({ likeId: data.id, likeCount: data.like_count })
        );
    }
  }

  render() {
    return (
      <span style={{ cursor: "pointer" }} onClick={this.toggleLike}>
        {this.state.likeId ? "❤️ " : "💔 "}
        {this.state.likeCount} like(s)
      </span>
    );
  }
}

export default LikeWidget;