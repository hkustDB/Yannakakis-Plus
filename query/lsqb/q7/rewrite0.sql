## AggReduce Phase: 

# AggReduce0
# 1. aggView
create or replace view aggView5859118812951571059 as select ParentMessageId as v1, COUNT(*) as annot from Comment_replyOf_Message as Comment_replyOf_Message group by ParentMessageId;
# 2. aggJoin
create or replace view aggJoin7544371069236739821 as select MessageId as v1, annot from Message_hasCreator_Person as Message_hasCreator_Person, aggView5859118812951571059 where Message_hasCreator_Person.MessageId=aggView5859118812951571059.v1;

# AggReduce1
# 1. aggView
create or replace view aggView8990028244664983606 as select v1, SUM(annot) as annot from aggJoin7544371069236739821 group by v1;
# 2. aggJoin
create or replace view aggJoin6332328517647225296 as select MessageId as v1, annot from Person_likes_Message as Person_likes_Message, aggView8990028244664983606 where Person_likes_Message.MessageId=aggView8990028244664983606.v1;

# AggReduce2
# 1. aggView
create or replace view aggView7406767216591214666 as select MessageId as v1, COUNT(*) as annot from Message_hasTag_Tag as Message_hasTag_Tag group by MessageId;
# 2. aggJoin
create or replace view aggJoin26580212042683873 as select aggJoin6332328517647225296.annot * aggView7406767216591214666.annot as annot from aggJoin6332328517647225296 join aggView7406767216591214666 using(v1);
# Final result: 
select SUM(annot) as v9 from aggJoin26580212042683873;

# drop view aggView5859118812951571059, aggJoin7544371069236739821, aggView8990028244664983606, aggJoin6332328517647225296, aggView7406767216591214666, aggJoin26580212042683873;
