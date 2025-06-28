package com.example;

import org.junit.jupiter.api.Test;
import static org.mockito.Mockito.*;

public class MyServiceTest {

    @Test
    public void testVerifyInteraction() {
        ExternalApi mockApi = mock(ExternalApi.class);      // Step 1: Mock object
        MyService service = new MyService(mockApi);         // Step 2: Use in service

        service.fetchData();                                // Step 3: Call method

        verify(mockApi).getData();                          // Step 4: Verify interaction
    }
}
