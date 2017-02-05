// Sidecar
// Copyright (c) 2014, Crush & Lovely <engineering@crushlovely.com>
// Under the MIT License; see LICENSE file for details.

#import "CRLDigestExtensions.h"


#define CRLDIGESTTEST(digestName, hash) \
    describe(@"crl_" #digestName "Hash", ^{ \
        it(@"should return the correct hash of data", ^{ \
            NSData *data = [@"hi" dataUsingEncoding:NSUTF8StringEncoding]; \
            expect([data crl_ ## digestName ## Hash]).to.equal(hash); \
        }); \
    });

#define CRLHMACTEST(digestName, hash) \
    describe(@"crl_" #digestName "HMACWithKey:", ^{ \
        it(@"should return the correct HMAC", ^{ \
            NSData *data = [@"hi" dataUsingEncoding:NSUTF8StringEncoding]; \
            NSData *key = [@"key" dataUsingEncoding:NSUTF8StringEncoding]; \
            expect([data crl_ ## digestName ## HMACWithKey:key]).to.equal(hash); \
        }); \
    });


SpecBegin(NSData_CRLDigests)

CRLDIGESTTEST(MD2, @"5df8e8413364cb049ed00d7a6a3555a0")
CRLDIGESTTEST(MD4, @"cfaee2512bd25eb033236f0cd054e308")
CRLDIGESTTEST(MD5, @"49f68a5c8493ec2c0bf489821c21fc3b")

CRLDIGESTTEST(SHA1, @"c22b5f9178342609428d6f51b2c5af4c0bde6a42")
CRLDIGESTTEST(SHA224, @"1a15bca3e4ed3ab82367c6c434f86c41040bdac577fa1c2de62c3be0")
CRLDIGESTTEST(SHA256, @"8f434346648f6b96df89dda901c5176b10a6d83961dd3c1ac88b59b2dc327aa4")
CRLDIGESTTEST(SHA384, @"0791006df8128477244f53d0fdce210db81f55757510e26acee35c18a6bceaa28dcdbbfd6dc041b9b4dc7b1b54e37f52")
CRLDIGESTTEST(SHA512, @"150a14ed5bea6cc731cf86c41566ac427a8db48ef1b9fd626664b3bfbb99071fa4c922f33dde38719b8c8354e2b7ab9d77e0e67fc12843920a712e73d558e197")


CRLHMACTEST(MD5, @"77bc290440dec41a4d5c6f3f769482fc")
CRLHMACTEST(SHA1, @"7a57c768a439a123a3f0957800ab4f9d38c7403b")
CRLHMACTEST(SHA224, @"d8665cb4d3221ff828fc0a32d998839819802bfa694e2d5497a1f5a2")
CRLHMACTEST(SHA256, @"1c9dc82e5f8e5ed5a0180aad33b8204dea12fde2fb62ffb5e963035bf324a7a4")
CRLHMACTEST(SHA384, @"05e934a7adb136df3467adc6d765b7403acc6fef0de10f2b87372db50cde2256c41c5c2ba41fcc6cd2877f4ffaeb866f")
CRLHMACTEST(SHA512, @"5b27423cfcc1e84ba3968c0553ec1a6b9ba3515246a234dbb3ac5e620f9abfd0c74027f6139d017b80a12219ac527c52a44e1c39757952277ce14456d516d619")

SpecEnd
