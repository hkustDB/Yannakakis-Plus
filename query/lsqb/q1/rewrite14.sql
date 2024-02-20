## AggReduce Phase: 

# AggReduce126
# 1. aggView
create or replace view aggView8353950927612162571 as select CountryId as v4, COUNT(*) as annot from Country as Country group by CountryId;
# 2. aggJoin
create or replace view aggJoin3118719878914353125 as select CityId as v6, annot from City as City, aggView8353950927612162571 where City.isPartOf_CountryId=aggView8353950927612162571.v4;

# AggReduce127
# 1. aggView
create or replace view aggView628242028105928520 as select v6, SUM(annot) as annot from aggJoin3118719878914353125 group by v6;
# 2. aggJoin
create or replace view aggJoin8817318578157892564 as select PersonId as v8, annot from Person as Person, aggView628242028105928520 where Person.isLocatedIn_CityId=aggView628242028105928520.v6;

# AggReduce128
# 1. aggView
create or replace view aggView2832669385069781992 as select v8, SUM(annot) as annot from aggJoin8817318578157892564 group by v8;
# 2. aggJoin
create or replace view aggJoin8941221730172093467 as select ForumId as v9, annot from Forum_hasMember_Person as Forum_hasMember_Person, aggView2832669385069781992 where Forum_hasMember_Person.PersonId=aggView2832669385069781992.v8;

# AggReduce129
# 1. aggView
create or replace view aggView6374286853111818458 as select v9, SUM(annot) as annot from aggJoin8941221730172093467 group by v9;
# 2. aggJoin
create or replace view aggJoin6237659898363886374 as select ForumId as v9, annot from Forum as Forum, aggView6374286853111818458 where Forum.ForumId=aggView6374286853111818458.v9;

# AggReduce130
# 1. aggView
create or replace view aggView1375749761402995563 as select v9, SUM(annot) as annot from aggJoin6237659898363886374 group by v9;
# 2. aggJoin
create or replace view aggJoin3284146172704793488 as select PostId as v18, annot from Post as Post, aggView1375749761402995563 where Post.Forum_containerOfId=aggView1375749761402995563.v9;

# AggReduce131
# 1. aggView
create or replace view aggView7051841369507956589 as select v18, SUM(annot) as annot from aggJoin3284146172704793488 group by v18;
# 2. aggJoin
create or replace view aggJoin7447142663104853959 as select CommentId as v20, annot from Comment as Comment, aggView7051841369507956589 where Comment.replyOf_PostId=aggView7051841369507956589.v18;

# AggReduce132
# 1. aggView
create or replace view aggView596629047658810106 as select v20, SUM(annot) as annot from aggJoin7447142663104853959 group by v20;
# 2. aggJoin
create or replace view aggJoin4683123868622939354 as select TagId as v22, annot from Comment_hasTag_Tag as Comment_hasTag_Tag, aggView596629047658810106 where Comment_hasTag_Tag.CommentId=aggView596629047658810106.v20;

# AggReduce133
# 1. aggView
create or replace view aggView3905384183183674 as select TagClassId as v23, COUNT(*) as annot from TagClass as TagClass group by TagClassId;
# 2. aggJoin
create or replace view aggJoin8755450002893121750 as select TagId as v22, annot from Tag as Tag, aggView3905384183183674 where Tag.hasType_TagClassId=aggView3905384183183674.v23;

# AggReduce134
# 1. aggView
create or replace view aggView5930890352974418338 as select v22, SUM(annot) as annot from aggJoin8755450002893121750 group by v22;
# 2. aggJoin
create or replace view aggJoin7823497284418382788 as select aggJoin4683123868622939354.annot * aggView5930890352974418338.annot as annot from aggJoin4683123868622939354 join aggView5930890352974418338 using(v22);
# Final result: 
select SUM(annot) as v26 from aggJoin7823497284418382788;

# drop view aggView8353950927612162571, aggJoin3118719878914353125, aggView628242028105928520, aggJoin8817318578157892564, aggView2832669385069781992, aggJoin8941221730172093467, aggView6374286853111818458, aggJoin6237659898363886374, aggView1375749761402995563, aggJoin3284146172704793488, aggView7051841369507956589, aggJoin7447142663104853959, aggView596629047658810106, aggJoin4683123868622939354, aggView3905384183183674, aggJoin8755450002893121750, aggView5930890352974418338, aggJoin7823497284418382788;
