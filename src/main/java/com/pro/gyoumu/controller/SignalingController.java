package com.pro.gyoumu.controller;


import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.ResponseBody;

@Controller
public class SignalingController {

    @GetMapping("/chat")
    public String index() {
        return "vedioChat.jsp";
    }

    @PostMapping("/offer")
    @ResponseBody
    public String handleOffer(@RequestBody String offer) {
        // 处理来自客户端的Offer会话描述
        // 通常在这里你会处理Offer并将它发送给另一个客户端
        return "Offer received: " + offer;
    }

    @PostMapping("/answer")
    @ResponseBody
    public String handleAnswer(@RequestBody String answer) {
        // 处理来自客户端的Answer会话描述
        // 通常在这里你会处理Answer并将它发送给另一个客户端
        return "Answer received: " + answer;
    }

    @PostMapping("/ice-candidate")
    @ResponseBody
    public String handleIceCandidate(@RequestBody String iceCandidate) {
        // 处理来自客户端的ICE候选信息
        // 通常在这里你会处理ICE候选并将它发送给另一个客户端
        return "ICE candidate received: " + iceCandidate;
    }
}