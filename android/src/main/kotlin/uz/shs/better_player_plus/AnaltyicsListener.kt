package uz.shs.better_player_plus

import androidx.media3.common.PlaybackException
import androidx.media3.common.util.UnstableApi
import androidx.media3.exoplayer.analytics.AnalyticsListener
import androidx.media3.exoplayer.source.LoadEventInfo
import androidx.media3.exoplayer.source.MediaLoadData


@UnstableApi
class AnalyticsListener(private val eventSink: QueuingEventSink) : AnalyticsListener {
    override fun onPlayerError(eventTime: AnalyticsListener.EventTime, error: PlaybackException) {
        val eventData: MutableMap<String, Any> = HashMap()
        eventData["event"] = "analytics" // Custom event type for Dart
        eventData["collector"] = "error"
        eventData["code"] = error.errorCode
        eventData["message"] = error.message.toString()
        eventData["stack_trace"] = error.stackTraceToString()
        eventSink.success(eventData)
        super.onPlayerError(eventTime, error)
    }

    override fun onLoadCompleted(
        eventTime: AnalyticsListener.EventTime,
        loadEventInfo: LoadEventInfo,
        mediaLoadData: MediaLoadData
    ) {
        // Extract data:
        val fragmentSn = mediaLoadData.trackType
        val fragmentUrl = loadEventInfo.uri.toString()
        val bytesLoaded = loadEventInfo.bytesLoaded
        val loadDuration = loadEventInfo.loadDurationMs / 1000
        // Prepare data for Flutter
        val eventData: MutableMap<String, Any> = HashMap()
        eventData["event"] = "analytics" // Custom event type for Dart
        eventData["collector"] = "bandwidth"
        eventData["fragment_url"] = fragmentUrl
        eventData["bytes_size"] = bytesLoaded
        eventData["fragment_duration"] = loadDuration
        eventSink.success(eventData)
        super.onLoadCompleted(eventTime, loadEventInfo, mediaLoadData)
    }
}