## AggReduce Phase: 

# AggReduce243
# 1. aggView
create or replace view aggView9085556045076150972 as select ForumId as v9, COUNT(*) as annot from Forum as Forum group by ForumId;
# 2. aggJoin
create or replace view aggJoin6401218580349649191 as select ForumId as v9, PersonId as v8, annot from Forum_hasMember_Person as Forum_hasMember_Person, aggView9085556045076150972 where Forum_hasMember_Person.ForumId=aggView9085556045076150972.v9;

# AggReduce244
# 1. aggView
create or replace view aggView4883519265236624317 as select TagClassId as v23, COUNT(*) as annot from TagClass as TagClass group by TagClassId;
# 2. aggJoin
create or replace view aggJoin5803935814168704594 as select TagId as v22, annot from Tag as Tag, aggView4883519265236624317 where Tag.hasType_TagClassId=aggView4883519265236624317.v23;

# AggReduce245
# 1. aggView
create or replace view aggView2040414361845820646 as select v22, SUM(annot) as annot from aggJoin5803935814168704594 group by v22;
# 2. aggJoin
create or replace view aggJoin3206145958250795029 as select CommentId as v20, annot from Comment_hasTag_Tag as Comment_hasTag_Tag, aggView2040414361845820646 where Comment_hasTag_Tag.TagId=aggView2040414361845820646.v22;

# AggReduce246
# 1. aggView
create or replace view aggView4729194110356886770 as select v20, SUM(annot) as annot from aggJoin3206145958250795029 group by v20;
# 2. aggJoin
create or replace view aggJoin2831442189042022691 as select replyOf_PostId as v18, annot from Comment as Comment, aggView4729194110356886770 where Comment.CommentId=aggView4729194110356886770.v20;

# AggReduce247
# 1. aggView
create or replace view aggView716360033512491124 as select v18, SUM(annot) as annot from aggJoin2831442189042022691 group by v18;
# 2. aggJoin
create or replace view aggJoin4491477357546260886 as select Forum_containerOfId as v9, annot from Post as Post, aggView716360033512491124 where Post.PostId=aggView716360033512491124.v18;

# AggReduce248
# 1. aggView
create or replace view aggView4595140978305783031 as select v9, SUM(annot) as annot from aggJoin4491477357546260886 group by v9;
# 2. aggJoin
create or replace view aggJoin8370979286716293088 as select v8, aggJoin6401218580349649191.annot * aggView4595140978305783031.annot as annot from aggJoin6401218580349649191 join aggView4595140978305783031 using(v9);

# AggReduce249
# 1. aggView
create or replace view aggView2595011549622149532 as select v8, SUM(annot) as annot from aggJoin8370979286716293088 group by v8;
# 2. aggJoin
create or replace view aggJoin87393556809801764 as select isLocatedIn_CityId as v6, annot from Person as Person, aggView2595011549622149532 where Person.PersonId=aggView2595011549622149532.v8;

# AggReduce250
# 1. aggView
create or replace view aggView5070063186722779450 as select v6, SUM(annot) as annot from aggJoin87393556809801764 group by v6;
# 2. aggJoin
create or replace view aggJoin2707905296496430307 as select isPartOf_CountryId as v4, annot from City as City, aggView5070063186722779450 where City.CityId=aggView5070063186722779450.v6;

# AggReduce251
# 1. aggView
create or replace view aggView2808518975804373178 as select v4, SUM(annot) as annot from aggJoin2707905296496430307 group by v4;
# 2. aggJoin
create or replace view aggJoin7667612524075584360 as select annot from Country as Country, aggView2808518975804373178 where Country.CountryId=aggView2808518975804373178.v4;
# Final result: 
select SUM(annot) as v26 from aggJoin7667612524075584360;

# drop view aggView9085556045076150972, aggJoin6401218580349649191, aggView4883519265236624317, aggJoin5803935814168704594, aggView2040414361845820646, aggJoin3206145958250795029, aggView4729194110356886770, aggJoin2831442189042022691, aggView716360033512491124, aggJoin4491477357546260886, aggView4595140978305783031, aggJoin8370979286716293088, aggView2595011549622149532, aggJoin87393556809801764, aggView5070063186722779450, aggJoin2707905296496430307, aggView2808518975804373178, aggJoin7667612524075584360;
