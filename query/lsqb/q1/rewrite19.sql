## AggReduce Phase: 

# AggReduce171
# 1. aggView
create or replace view aggView9119324397201335003 as select TagClassId as v23, COUNT(*) as annot from TagClass as TagClass group by TagClassId;
# 2. aggJoin
create or replace view aggJoin7863742578048976585 as select TagId as v22, annot from Tag as Tag, aggView9119324397201335003 where Tag.hasType_TagClassId=aggView9119324397201335003.v23;

# AggReduce172
# 1. aggView
create or replace view aggView9169466824432158564 as select v22, SUM(annot) as annot from aggJoin7863742578048976585 group by v22;
# 2. aggJoin
create or replace view aggJoin7172440481214865816 as select CommentId as v20, annot from Comment_hasTag_Tag as Comment_hasTag_Tag, aggView9169466824432158564 where Comment_hasTag_Tag.TagId=aggView9169466824432158564.v22;

# AggReduce173
# 1. aggView
create or replace view aggView3661448790285781892 as select v20, SUM(annot) as annot from aggJoin7172440481214865816 group by v20;
# 2. aggJoin
create or replace view aggJoin1900236164174653380 as select replyOf_PostId as v18, annot from Comment as Comment, aggView3661448790285781892 where Comment.CommentId=aggView3661448790285781892.v20;

# AggReduce174
# 1. aggView
create or replace view aggView6387723458011429685 as select v18, SUM(annot) as annot from aggJoin1900236164174653380 group by v18;
# 2. aggJoin
create or replace view aggJoin727923058604331956 as select Forum_containerOfId as v9, annot from Post as Post, aggView6387723458011429685 where Post.PostId=aggView6387723458011429685.v18;

# AggReduce175
# 1. aggView
create or replace view aggView1135683232160204646 as select v9, SUM(annot) as annot from aggJoin727923058604331956 group by v9;
# 2. aggJoin
create or replace view aggJoin1239844945873944601 as select ForumId as v9, annot from Forum as Forum, aggView1135683232160204646 where Forum.ForumId=aggView1135683232160204646.v9;

# AggReduce176
# 1. aggView
create or replace view aggView8137221334666316309 as select v9, SUM(annot) as annot from aggJoin1239844945873944601 group by v9;
# 2. aggJoin
create or replace view aggJoin1138565620078696030 as select PersonId as v8, annot from Forum_hasMember_Person as Forum_hasMember_Person, aggView8137221334666316309 where Forum_hasMember_Person.ForumId=aggView8137221334666316309.v9;

# AggReduce177
# 1. aggView
create or replace view aggView5055435811349813818 as select v8, SUM(annot) as annot from aggJoin1138565620078696030 group by v8;
# 2. aggJoin
create or replace view aggJoin3964825005153317205 as select isLocatedIn_CityId as v6, annot from Person as Person, aggView5055435811349813818 where Person.PersonId=aggView5055435811349813818.v8;

# AggReduce178
# 1. aggView
create or replace view aggView9064592581129881654 as select v6, SUM(annot) as annot from aggJoin3964825005153317205 group by v6;
# 2. aggJoin
create or replace view aggJoin3687281455384051899 as select isPartOf_CountryId as v4, annot from City as City, aggView9064592581129881654 where City.CityId=aggView9064592581129881654.v6;

# AggReduce179
# 1. aggView
create or replace view aggView7428193492702721231 as select v4, SUM(annot) as annot from aggJoin3687281455384051899 group by v4;
# 2. aggJoin
create or replace view aggJoin7561249161100331892 as select annot from Country as Country, aggView7428193492702721231 where Country.CountryId=aggView7428193492702721231.v4;
# Final result: 
select SUM(annot) as v26 from aggJoin7561249161100331892;

# drop view aggView9119324397201335003, aggJoin7863742578048976585, aggView9169466824432158564, aggJoin7172440481214865816, aggView3661448790285781892, aggJoin1900236164174653380, aggView6387723458011429685, aggJoin727923058604331956, aggView1135683232160204646, aggJoin1239844945873944601, aggView8137221334666316309, aggJoin1138565620078696030, aggView5055435811349813818, aggJoin3964825005153317205, aggView9064592581129881654, aggJoin3687281455384051899, aggView7428193492702721231, aggJoin7561249161100331892;
