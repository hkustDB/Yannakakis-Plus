## AggReduce Phase: 

# AggReduce96
# 1. aggView
create or replace view aggView4892942659154798546 as select MessageId as v1, COUNT(*) as annot from Message_hasCreator_Person as Message_hasCreator_Person group by MessageId;
# 2. aggJoin
create or replace view aggJoin8667867283152530095 as select MessageId as v1, annot from Person_likes_Message as Person_likes_Message, aggView4892942659154798546 where Person_likes_Message.MessageId=aggView4892942659154798546.v1;

# AggReduce97
# 1. aggView
create or replace view aggView6219799727727132628 as select v1, SUM(annot) as annot from aggJoin8667867283152530095 group by v1;
# 2. aggJoin
create or replace view aggJoin7134726618643848035 as select ParentMessageId as v1, annot from Comment_replyOf_Message as Comment_replyOf_Message, aggView6219799727727132628 where Comment_replyOf_Message.ParentMessageId=aggView6219799727727132628.v1;

# AggReduce98
# 1. aggView
create or replace view aggView5722778489894672354 as select MessageId as v1, COUNT(*) as annot from Message_hasTag_Tag as Message_hasTag_Tag group by MessageId;
# 2. aggJoin
create or replace view aggJoin2516312007451405940 as select aggJoin7134726618643848035.annot * aggView5722778489894672354.annot as annot from aggJoin7134726618643848035 join aggView5722778489894672354 using(v1);
# Final result: 
select SUM(annot) as v9 from aggJoin2516312007451405940;

# drop view aggView4892942659154798546, aggJoin8667867283152530095, aggView6219799727727132628, aggJoin7134726618643848035, aggView5722778489894672354, aggJoin2516312007451405940;
