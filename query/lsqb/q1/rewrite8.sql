## AggReduce Phase: 

# AggReduce72
# 1. aggView
create or replace view aggView9123372955222933104 as select ForumId as v9, COUNT(*) as annot from Forum as Forum group by ForumId;
# 2. aggJoin
create or replace view aggJoin4331660244379854681 as select PostId as v18, Forum_containerOfId as v9, annot from Post as Post, aggView9123372955222933104 where Post.Forum_containerOfId=aggView9123372955222933104.v9;

# AggReduce73
# 1. aggView
create or replace view aggView4817453484371230522 as select TagClassId as v23, COUNT(*) as annot from TagClass as TagClass group by TagClassId;
# 2. aggJoin
create or replace view aggJoin2061064407701079817 as select TagId as v22, annot from Tag as Tag, aggView4817453484371230522 where Tag.hasType_TagClassId=aggView4817453484371230522.v23;

# AggReduce74
# 1. aggView
create or replace view aggView7418904095547083399 as select v22, SUM(annot) as annot from aggJoin2061064407701079817 group by v22;
# 2. aggJoin
create or replace view aggJoin1346912709339817802 as select CommentId as v20, annot from Comment_hasTag_Tag as Comment_hasTag_Tag, aggView7418904095547083399 where Comment_hasTag_Tag.TagId=aggView7418904095547083399.v22;

# AggReduce75
# 1. aggView
create or replace view aggView1651339984749124838 as select v20, SUM(annot) as annot from aggJoin1346912709339817802 group by v20;
# 2. aggJoin
create or replace view aggJoin2956281625120562337 as select replyOf_PostId as v18, annot from Comment as Comment, aggView1651339984749124838 where Comment.CommentId=aggView1651339984749124838.v20;

# AggReduce76
# 1. aggView
create or replace view aggView5408703832665439088 as select v18, SUM(annot) as annot from aggJoin2956281625120562337 group by v18;
# 2. aggJoin
create or replace view aggJoin5934528082769243988 as select v9, aggJoin4331660244379854681.annot * aggView5408703832665439088.annot as annot from aggJoin4331660244379854681 join aggView5408703832665439088 using(v18);

# AggReduce77
# 1. aggView
create or replace view aggView6596104606032876405 as select v9, SUM(annot) as annot from aggJoin5934528082769243988 group by v9;
# 2. aggJoin
create or replace view aggJoin4711692756802905610 as select PersonId as v8, annot from Forum_hasMember_Person as Forum_hasMember_Person, aggView6596104606032876405 where Forum_hasMember_Person.ForumId=aggView6596104606032876405.v9;

# AggReduce78
# 1. aggView
create or replace view aggView4658241088364447901 as select v8, SUM(annot) as annot from aggJoin4711692756802905610 group by v8;
# 2. aggJoin
create or replace view aggJoin6039076915061465513 as select isLocatedIn_CityId as v6, annot from Person as Person, aggView4658241088364447901 where Person.PersonId=aggView4658241088364447901.v8;

# AggReduce79
# 1. aggView
create or replace view aggView5984500129344200463 as select v6, SUM(annot) as annot from aggJoin6039076915061465513 group by v6;
# 2. aggJoin
create or replace view aggJoin1729767876003498253 as select isPartOf_CountryId as v4, annot from City as City, aggView5984500129344200463 where City.CityId=aggView5984500129344200463.v6;

# AggReduce80
# 1. aggView
create or replace view aggView6891811307270131053 as select v4, SUM(annot) as annot from aggJoin1729767876003498253 group by v4;
# 2. aggJoin
create or replace view aggJoin1328166119137503710 as select annot from Country as Country, aggView6891811307270131053 where Country.CountryId=aggView6891811307270131053.v4;
# Final result: 
select SUM(annot) as v26 from aggJoin1328166119137503710;

# drop view aggView9123372955222933104, aggJoin4331660244379854681, aggView4817453484371230522, aggJoin2061064407701079817, aggView7418904095547083399, aggJoin1346912709339817802, aggView1651339984749124838, aggJoin2956281625120562337, aggView5408703832665439088, aggJoin5934528082769243988, aggView6596104606032876405, aggJoin4711692756802905610, aggView4658241088364447901, aggJoin6039076915061465513, aggView5984500129344200463, aggJoin1729767876003498253, aggView6891811307270131053, aggJoin1328166119137503710;
