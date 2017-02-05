// Sidecar
// Copyright (c) 2014, Crush & Lovely <engineering@crushlovely.com>
// Under the MIT License; see LICENSE file for details.

#import "CRLDigestExtensions.h"


#define CRLSTRINGHASHTEST(hashName, hiHash, pooHash, emptyHash) \
    describe(@"crl_" #hashName "Hash", ^{ \
        it(@"should return the correct hash of a string", ^{ \
            expect([@"hi" crl_ ## hashName ## Hash]).to.equal(hiHash); \
        }); \
        it(@"should hash the UTF8 encoding of a string", ^{ \
            expect([@"💩" crl_ ## hashName ## Hash]).to.equal(pooHash); \
        }); \
        it(@"should properly hash the empty string", ^{ \
            expect([@"" crl_ ## hashName ## Hash]).to.equal(emptyHash); \
        }); \
    });

#define CRLSTRINGHMACTEST(digestName, hash) \
    describe(@"crl_" #digestName "HMACWithKey:", ^{ \
        it(@"should return the correct HMAC", ^{ \
            NSData *key = [@"key" dataUsingEncoding:NSUTF8StringEncoding]; \
            expect([@"hi😈" crl_ ## digestName ## HMACWithKey:key]).to.equal(hash); \
        }); \
    });


SpecBegin(NSString_CRLDigests)

describe(@"hash functions", ^{
    CRLSTRINGHASHTEST(MD2,
                      @"5df8e8413364cb049ed00d7a6a3555a0",
                      @"48ce2abd45745f4de5579ac4146ea290",
                      @"8350e5a3e24c153df2275c9f80692773")

    CRLSTRINGHASHTEST(MD4,
                      @"cfaee2512bd25eb033236f0cd054e308",
                      @"ac3edd28778e0b0d0569f160f68d28c0",
                      @"31d6cfe0d16ae931b73c59d7e0c089c0")

    CRLSTRINGHASHTEST(MD5,
                      @"49f68a5c8493ec2c0bf489821c21fc3b",
                      @"bd49d549f7c1f0169d6d61322a02d39d",
                      @"d41d8cd98f00b204e9800998ecf8427e")

    CRLSTRINGHASHTEST(SHA1,
                      @"c22b5f9178342609428d6f51b2c5af4c0bde6a42",
                      @"82ab1e5bf66129bdbb3d5477dfe48bfcb2545cbd",
                      @"da39a3ee5e6b4b0d3255bfef95601890afd80709")

    CRLSTRINGHASHTEST(SHA224,
                      @"1a15bca3e4ed3ab82367c6c434f86c41040bdac577fa1c2de62c3be0",
                      @"32e1bf28adf2be01bd01401cfd732d3831914a04d1d81ad1cd54e008",
                      @"d14a028c2a3a2bc9476102bb288234c415a2b01f828ea62ac5b3e42f")

    CRLSTRINGHASHTEST(SHA256,
                      @"8f434346648f6b96df89dda901c5176b10a6d83961dd3c1ac88b59b2dc327aa4",
                      @"34722ef0267ceda14f0e2b756b83e85d6e79e458967895e72b07f87da7c0e275",
                      @"e3b0c44298fc1c149afbf4c8996fb92427ae41e4649b934ca495991b7852b855")

    CRLSTRINGHASHTEST(SHA384,
                      @"0791006df8128477244f53d0fdce210db81f55757510e26acee35c18a6bceaa28dcdbbfd6dc041b9b4dc7b1b54e37f52",
                      @"ccb07e35da7dd238b097084c5046d156ca8b171e782393f79eea9e7f36d947791dca00a3c6c280fd01a6550c59273e39",
                      @"38b060a751ac96384cd9327eb1b1e36a21fdb71114be07434c0cc7bf63f6e1da274edebfe76f65fbd51ad2f14898b95b")

    CRLSTRINGHASHTEST(SHA512,
                      @"150a14ed5bea6cc731cf86c41566ac427a8db48ef1b9fd626664b3bfbb99071fa4c922f33dde38719b8c8354e2b7ab9d77e0e67fc12843920a712e73d558e197",
                      @"30a57cb9d2d5d7fdbcff663c7251fbe9e2f652a5f43e84cb72fb98b3efb80b51cba370ab37752e9c2a1e6afd7b929f9e8b68831f35c49bffcc3c52941068d755",
                      @"cf83e1357eefb8bdf1542850d66d8007d620e4050b5715dc83f4a921d36ce9ce47d0d13c5d85f2b0ff8318d2877eec2f63b931bd47417a81a538327af927da3e")


    CRLSTRINGHMACTEST(MD5, @"7a9b66c276caba867228e6eca3e9643e")
    CRLSTRINGHMACTEST(SHA1, @"ff61ea46544aac6deaa51664fc8c6db113668492")
    CRLSTRINGHMACTEST(SHA224, @"d45e0f2df86b67afc93ca233386485852aaf3a6a36330f124687a7d4")
    CRLSTRINGHMACTEST(SHA256, @"a12087680f9a6f07b65f0097471ae4a647e11878ee3fb4bdc875ac717b14e7a0")
    CRLSTRINGHMACTEST(SHA384, @"681c59a42d953b385125bcc7c2b3a1032d2810b7200fb007346c59a0260a6cbe13abcc62c5613e16315d12da83bc2593")
    CRLSTRINGHMACTEST(SHA512, @"2d63637ef8c429707c6833472d4abe42bbe2968600caf8e0619bf0b9367143844e7f6f59ae060502d4d08756242441d487fa058627ce7e0ab30b0d40c2bdf30f")
});

SpecEnd
