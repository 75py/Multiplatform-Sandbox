package com.nagopy.multiplatform.sandbox

import androidx.compose.foundation.horizontalScroll
import androidx.compose.foundation.layout.height
import androidx.compose.foundation.layout.padding
import androidx.compose.foundation.layout.width
import androidx.compose.foundation.lazy.LazyRow
import androidx.compose.foundation.lazy.items
import androidx.compose.foundation.rememberScrollState
import androidx.compose.material.Button
import androidx.compose.material.Text
import androidx.compose.runtime.Composable
import androidx.compose.runtime.getValue
import androidx.compose.runtime.mutableStateOf
import androidx.compose.runtime.remember
import androidx.compose.runtime.setValue
import androidx.compose.ui.Modifier
import androidx.compose.ui.unit.dp

@Composable
fun HorizontalScrollRow(rowIds: List<Int> = IntRange(0, 20).toList()) {
    LazyRow(
        modifier = Modifier
            .horizontalScroll(rememberScrollState())
            .padding(16.dp)
            .width(300.dp)
            .height(100.dp)
    ) {
        items(
            items = rowIds,
            key = { rowId -> rowId }
        ) { rowId ->
            var text by remember { mutableStateOf("Text $rowId") }
            Button(onClick = {
                text = "Clicked $rowId"
            }) {
                Text(text)
            }
        }
    }
}