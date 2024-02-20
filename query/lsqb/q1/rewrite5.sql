## AggReduce Phase: 

# AggReduce45
# 1. aggView
create or replace view aggView7191654910436654773 as select CountryId as v4, COUNT(*) as annot from Country as Country group by CountryId;
# 2. aggJoin
create or replace view aggJoin3239530725418710044 as select CityId as v6, annot from City as City, aggView7191654910436654773 where City.isPartOf_CountryId=aggView7191654910436654773.v4;

# AggReduce46
# 1. aggView
create or replace view aggView1846651485205297911 as select v6, SUM(annot) as annot from aggJoin3239530725418710044 group by v6;
# 2. aggJoin
create or replace view aggJoin39769673384021618 as select PersonId as v8, annot from Person as Person, aggView1846651485205297911 where Person.isLocatedIn_CityId=aggView1846651485205297911.v6;

# AggReduce47
# 1. aggView
create or replace view aggView2967527924266492368 as select v8, SUM(annot) as annot from aggJoin39769673384021618 group by v8;
# 2. aggJoin
create or replace view aggJoin4424154353953523869 as select ForumId as v9, annot from Forum_hasMember_Person as Forum_hasMember_Person, aggView2967527924266492368 where Forum_hasMember_Person.PersonId=aggView2967527924266492368.v8;

# AggReduce48
# 1. aggView
create or replace view aggView3659188691892778642 as select v9, SUM(annot) as annot from aggJoin4424154353953523869 group by v9;
# 2. aggJoin
create or replace view aggJoin586816992877571034 as select PostId as v18, Forum_containerOfId as v9, annot from Post as Post, aggView3659188691892778642 where Post.Forum_containerOfId=aggView3659188691892778642.v9;

# AggReduce49
# 1. aggView
create or replace view aggView1960581884089196400 as select ForumId as v9, COUNT(*) as annot from Forum as Forum group by ForumId;
# 2. aggJoin
create or replace view aggJoin2033584282539562 as select v18, aggJoin586816992877571034.annot * aggView1960581884089196400.annot as annot from aggJoin586816992877571034 join aggView1960581884089196400 using(v9);

# AggReduce50
# 1. aggView
create or replace view aggView7348192754686040815 as select v18, SUM(annot) as annot from aggJoin2033584282539562 group by v18;
# 2. aggJoin
create or replace view aggJoin1698387636929797250 as select CommentId as v20, annot from Comment as Comment, aggView7348192754686040815 where Comment.replyOf_PostId=aggView7348192754686040815.v18;

# AggReduce51
# 1. aggView
create or replace view aggView2911873186864021025 as select TagClassId as v23, COUNT(*) as annot from TagClass as TagClass group by TagClassId;
# 2. aggJoin
create or replace view aggJoin8684590602417603780 as select TagId as v22, annot from Tag as Tag, aggView2911873186864021025 where Tag.hasType_TagClassId=aggView2911873186864021025.v23;

# AggReduce52
# 1. aggView
create or replace view aggView6715101120848236536 as select v22, SUM(annot) as annot from aggJoin8684590602417603780 group by v22;
# 2. aggJoin
create or replace view aggJoin904798724681018855 as select CommentId as v20, annot from Comment_hasTag_Tag as Comment_hasTag_Tag, aggView6715101120848236536 where Comment_hasTag_Tag.TagId=aggView6715101120848236536.v22;

# AggReduce53
# 1. aggView
create or replace view aggView2380727312077266773 as select v20, SUM(annot) as annot from aggJoin904798724681018855 group by v20;
# 2. aggJoin
create or replace view aggJoin7493324555908121774 as select aggJoin1698387636929797250.annot * aggView2380727312077266773.annot as annot from aggJoin1698387636929797250 join aggView2380727312077266773 using(v20);
# Final result: 
select SUM(annot) as v26 from aggJoin7493324555908121774;

# drop view aggView7191654910436654773, aggJoin3239530725418710044, aggView1846651485205297911, aggJoin39769673384021618, aggView2967527924266492368, aggJoin4424154353953523869, aggView3659188691892778642, aggJoin586816992877571034, aggView1960581884089196400, aggJoin2033584282539562, aggView7348192754686040815, aggJoin1698387636929797250, aggView2911873186864021025, aggJoin8684590602417603780, aggView6715101120848236536, aggJoin904798724681018855, aggView2380727312077266773, aggJoin7493324555908121774;
