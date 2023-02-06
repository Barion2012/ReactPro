using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;
using System.Text.Json;
using System.Threading;
using System.IO;

namespace HelloApi.Extensions
{
    public static partial class JsonSerializerExtensions
    {
        public static T? JsonDeserialize<T>(this string json, T anonymousTypeObject, JsonSerializerOptions? options = default)
            => JsonSerializer.Deserialize<T>(json, options);

        public static ValueTask<TValue?> JsonDeserializeAsync<TValue>(this Stream stream, TValue anonymousTypeObject, JsonSerializerOptions? options = default, CancellationToken cancellationToken = default)
            => JsonSerializer.DeserializeAsync<TValue>(stream, options, cancellationToken);
    }

}
