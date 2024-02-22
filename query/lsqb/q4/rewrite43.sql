create or replace view aggView2791832854352225624 as select ParentMessageId as v1, COUNT(*) as annot from Comment_replyOf_Message as Comment_replyOf_Message group by ParentMessageId;
create or replace view aggJoin5522614196692734127 as select MessageId as v1, annot from Person_likes_Message as Person_likes_Message, aggView2791832854352225624 where Person_likes_Message.MessageId=aggView2791832854352225624.v1;
create or replace view aggView5963871361922306720 as select MessageId as v1, COUNT(*) as annot from Message_hasTag_Tag as Message_hasTag_Tag group by MessageId;
create or replace view aggJoin6602880894575167560 as select v1, aggJoin5522614196692734127.annot * aggView5963871361922306720.annot as annot from aggJoin5522614196692734127 join aggView5963871361922306720 using(v1);
create or replace view aggView8740813710565652826 as select v1, SUM(annot) as annot from aggJoin6602880894575167560 group by v1;
create or replace view aggJoin8953031843166418501 as select annot from Message_hasCreator_Person as Message_hasCreator_Person, aggView8740813710565652826 where Message_hasCreator_Person.MessageId=aggView8740813710565652826.v1;
select SUM(annot) as v9 from aggJoin8953031843166418501;
