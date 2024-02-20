## AggReduce Phase: 

# AggReduce186
# 1. aggView
create or replace view aggView3366087944816753527 as select MessageId as v1, COUNT(*) as annot from Person_likes_Message as Person_likes_Message group by MessageId;
# 2. aggJoin
create or replace view aggJoin7685330738796676497 as select MessageId as v1, annot from Message_hasTag_Tag as Message_hasTag_Tag, aggView3366087944816753527 where Message_hasTag_Tag.MessageId=aggView3366087944816753527.v1;

# AggReduce187
# 1. aggView
create or replace view aggView2915788210709449846 as select MessageId as v1, COUNT(*) as annot from Message_hasCreator_Person as Message_hasCreator_Person group by MessageId;
# 2. aggJoin
create or replace view aggJoin2772736009562302131 as select v1, aggJoin7685330738796676497.annot * aggView2915788210709449846.annot as annot from aggJoin7685330738796676497 join aggView2915788210709449846 using(v1);

# AggReduce188
# 1. aggView
create or replace view aggView7735570409220748864 as select v1, SUM(annot) as annot from aggJoin2772736009562302131 group by v1;
# 2. aggJoin
create or replace view aggJoin6608638510594493952 as select annot from Comment_replyOf_Message as Comment_replyOf_Message, aggView7735570409220748864 where Comment_replyOf_Message.ParentMessageId=aggView7735570409220748864.v1;
# Final result: 
select SUM(annot) as v9 from aggJoin6608638510594493952;

# drop view aggView3366087944816753527, aggJoin7685330738796676497, aggView2915788210709449846, aggJoin2772736009562302131, aggView7735570409220748864, aggJoin6608638510594493952;
