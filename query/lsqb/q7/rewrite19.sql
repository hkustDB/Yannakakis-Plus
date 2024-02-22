create or replace view aggView5444421392438240248 as select MessageId as v1, COUNT(*) as annot from Person_likes_Message as Person_likes_Message group by MessageId;
create or replace view aggJoin2028431499564574906 as select ParentMessageId as v1, annot from Comment_replyOf_Message as Comment_replyOf_Message, aggView5444421392438240248 where Comment_replyOf_Message.ParentMessageId=aggView5444421392438240248.v1;
create or replace view aggView5035547183214151922 as select MessageId as v1, COUNT(*) as annot from Message_hasTag_Tag as Message_hasTag_Tag group by MessageId;
create or replace view aggJoin7533699932927893860 as select v1, aggJoin2028431499564574906.annot * aggView5035547183214151922.annot as annot from aggJoin2028431499564574906 join aggView5035547183214151922 using(v1);
create or replace view aggView5776275402876254524 as select v1, SUM(annot) as annot from aggJoin7533699932927893860 group by v1;
create or replace view aggJoin6501251952938554093 as select annot from Message_hasCreator_Person as Message_hasCreator_Person, aggView5776275402876254524 where Message_hasCreator_Person.MessageId=aggView5776275402876254524.v1;
select SUM(annot) as v9 from aggJoin6501251952938554093;
