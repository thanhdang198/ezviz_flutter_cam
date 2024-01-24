package com.example.ys_play;

import android.os.Handler;
import android.os.Message;

import androidx.annotation.NonNull;

import com.example.ys_play.Interface.YsResultListener;
import com.example.ys_play.utils.LogUtils;
import com.videogo.errorlayer.ErrorInfo;
import com.videogo.exception.ErrorCode;
import com.videogo.openapi.EZConstants;

class YsPlayViewHandler extends Handler {
    private final YsResultListener ysResult;

    public YsPlayViewHandler(YsResultListener ysResult){
        this.ysResult = ysResult;
    }

    @Override
    public void handleMessage(@NonNull Message msg) {
        ErrorInfo errorinfo = new ErrorInfo();
        if(msg.obj!=null && msg.obj.getClass() == ErrorInfo.class){
            errorinfo = (ErrorInfo) msg.obj;
        }
        switch (msg.what) {
            case EZConstants.EZPlaybackConstants.MSG_REMOTEPLAYBACK_PLAY_SUCCUSS:
                LogUtils.d("Replay played successfully");
                ysResult.onPlaySuccess();
                break;
            case EZConstants.EZPlaybackConstants.MSG_REMOTEPLAYBACK_PLAY_FAIL:
            case EZConstants.EZRealPlayConstants.MSG_REALPLAY_PLAY_FAIL:
                //得到播放失败描述
                String description = errorinfo.description;
                //错误信息回调
                ysResult.onPlayError(description);
                break;
            case EZConstants.MSG_VIDEO_SIZE_CHANGED:
                //解析出视频画面分辨率回调
                break;
            case EZConstants.EZRealPlayConstants.MSG_REALPLAY_PLAY_SUCCESS:
                LogUtils.d("Live broadcast successfully");
                ysResult.onPlaySuccess();
                break;
            case EZConstants.EZRealPlayConstants.MSG_REALPLAY_VOICETALK_FAIL:
                handleVoiceTalkFailed(errorinfo);
                break;
            case EZConstants.EZRealPlayConstants.MSG_REALPLAY_VOICETALK_SUCCESS:
                LogUtils.d("Intercom successful");
                ysResult.onTalkSuccess();
                break;
            default:
                break;
        }
    }

    /**
     * 对讲失败
     * @param errorInfo:错误信息
     */
    private void handleVoiceTalkFailed(ErrorInfo errorInfo) {
        String errorDes = "";
        switch (errorInfo.errorCode) {
            case ErrorCode.ERROR_TRANSF_DEVICE_TALKING:
                errorDes = "You can only intercom with one device at the same time. Please stop other intercoms and try again.";
                break;
            case ErrorCode.ERROR_TRANSF_DEVICE_PRIVACYON:
                errorDes = "Intercom cannot be done in privacy protection mode";
                break;
            case ErrorCode.ERROR_TRANSF_DEVICE_OFFLINE:
                errorDes = "Device is not online";
                break;
            case ErrorCode.ERROR_TTS_MSG_REQ_TIMEOUT:
            case ErrorCode.ERROR_TTS_MSG_SVR_HANDLE_TIMEOUT:
            case ErrorCode.ERROR_TTS_WAIT_TIMEOUT:
            case ErrorCode.ERROR_TTS_HNADLE_TIMEOUT:
                errorDes="Request timed out, intercom is closed";
                break;
            case ErrorCode.ERROR_CAS_AUDIO_SOCKET_ERROR:
            case ErrorCode.ERROR_CAS_AUDIO_RECV_ERROR:
            case ErrorCode.ERROR_CAS_AUDIO_SEND_ERROR:
                errorDes="Network abnormality, intercom is closed";
                break;
            case ErrorCode.ERROR_INNER_STREAM_TIMEOUT:
                errorDes="Fetching stream timed out, refresh and try again";
                break;
            case 110031://子账户或萤石用户没有权限
                break;
            default:
                errorDes = "" + errorInfo.errorCode;
                break;
        }
        ysResult.onTalkError(errorDes);
    }



}
