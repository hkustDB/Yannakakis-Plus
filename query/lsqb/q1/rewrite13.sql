## AggReduce Phase: 

# AggReduce117
# 1. aggView
create or replace view aggView7353987825062065111 as select CountryId as v4, COUNT(*) as annot from Country as Country group by CountryId;
# 2. aggJoin
create or replace view aggJoin1909837505257946683 as select CityId as v6, annot from City as City, aggView7353987825062065111 where City.isPartOf_CountryId=aggView7353987825062065111.v4;

# AggReduce118
# 1. aggView
create or replace view aggView4796935873011315215 as select v6, SUM(annot) as annot from aggJoin1909837505257946683 group by v6;
# 2. aggJoin
create or replace view aggJoin4266785983148050566 as select PersonId as v8, annot from Person as Person, aggView4796935873011315215 where Person.isLocatedIn_CityId=aggView4796935873011315215.v6;

# AggReduce119
# 1. aggView
create or replace view aggView674810148266707439 as select v8, SUM(annot) as annot from aggJoin4266785983148050566 group by v8;
# 2. aggJoin
create or replace view aggJoin3383327698595061839 as select ForumId as v9, annot from Forum_hasMember_Person as Forum_hasMember_Person, aggView674810148266707439 where Forum_hasMember_Person.PersonId=aggView674810148266707439.v8;

# AggReduce120
# 1. aggView
create or replace view aggView2033716554649742343 as select v9, SUM(annot) as annot from aggJoin3383327698595061839 group by v9;
# 2. aggJoin
create or replace view aggJoin4600097702049659044 as select ForumId as v9, annot from Forum as Forum, aggView2033716554649742343 where Forum.ForumId=aggView2033716554649742343.v9;

# AggReduce121
# 1. aggView
create or replace view aggView2382009825589028019 as select TagClassId as v23, COUNT(*) as annot from TagClass as TagClass group by TagClassId;
# 2. aggJoin
create or replace view aggJoin3244472870499324315 as select TagId as v22, annot from Tag as Tag, aggView2382009825589028019 where Tag.hasType_TagClassId=aggView2382009825589028019.v23;

# AggReduce122
# 1. aggView
create or replace view aggView7230170465038796597 as select v22, SUM(annot) as annot from aggJoin3244472870499324315 group by v22;
# 2. aggJoin
create or replace view aggJoin4038859451646090893 as select CommentId as v20, annot from Comment_hasTag_Tag as Comment_hasTag_Tag, aggView7230170465038796597 where Comment_hasTag_Tag.TagId=aggView7230170465038796597.v22;

# AggReduce123
# 1. aggView
create or replace view aggView5236249612660736202 as select v20, SUM(annot) as annot from aggJoin4038859451646090893 group by v20;
# 2. aggJoin
create or replace view aggJoin4949551178777206206 as select replyOf_PostId as v18, annot from Comment as Comment, aggView5236249612660736202 where Comment.CommentId=aggView5236249612660736202.v20;

# AggReduce124
# 1. aggView
create or replace view aggView6695024773717379375 as select v18, SUM(annot) as annot from aggJoin4949551178777206206 group by v18;
# 2. aggJoin
create or replace view aggJoin2270213030170862905 as select Forum_containerOfId as v9, annot from Post as Post, aggView6695024773717379375 where Post.PostId=aggView6695024773717379375.v18;

# AggReduce125
# 1. aggView
create or replace view aggView7411270207297249180 as select v9, SUM(annot) as annot from aggJoin2270213030170862905 group by v9;
# 2. aggJoin
create or replace view aggJoin6769481932016422031 as select aggJoin4600097702049659044.annot * aggView7411270207297249180.annot as annot from aggJoin4600097702049659044 join aggView7411270207297249180 using(v9);
# Final result: 
select SUM(annot) as v26 from aggJoin6769481932016422031;

# drop view aggView7353987825062065111, aggJoin1909837505257946683, aggView4796935873011315215, aggJoin4266785983148050566, aggView674810148266707439, aggJoin3383327698595061839, aggView2033716554649742343, aggJoin4600097702049659044, aggView2382009825589028019, aggJoin3244472870499324315, aggView7230170465038796597, aggJoin4038859451646090893, aggView5236249612660736202, aggJoin4949551178777206206, aggView6695024773717379375, aggJoin2270213030170862905, aggView7411270207297249180, aggJoin6769481932016422031;
