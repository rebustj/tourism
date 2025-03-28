package app.tourism.data.dto

import android.os.Parcelable
import app.organicmaps.bookmarks.data.FeatureId
import app.organicmaps.bookmarks.data.MapObject
import app.tourism.data.db.entities.CoordinatesEntity
import kotlinx.parcelize.Parcelize

@Parcelize
data class PlaceLocation(val name: String, val lat: Double, val lon: Double) : Parcelable {
    fun toMapObject() = MapObject.createMapObject(
        FeatureId.EMPTY, MapObject.POI, name, "", lat, lon
    );

    fun toCoordinatesEntity() = CoordinatesEntity(lat, lon)
}