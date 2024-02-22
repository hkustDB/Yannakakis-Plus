create or replace view aggView5956377008003793396 as select MessageId as v1, COUNT(*) as annot from Message_hasTag_Tag as Message_hasTag_Tag group by MessageId;
create or replace view aggJoin7901736438724267156 as select MessageId as v1, annot from Person_likes_Message as Person_likes_Message, aggView5956377008003793396 where Person_likes_Message.MessageId=aggView5956377008003793396.v1;
create or replace view aggView6742341666283180167 as select v1, SUM(annot) as annot from aggJoin7901736438724267156 group by v1;
create or replace view aggJoin2321192459004253572 as select MessageId as v1, annot from Message_hasCreator_Person as Message_hasCreator_Person, aggView6742341666283180167 where Message_hasCreator_Person.MessageId=aggView6742341666283180167.v1;
create or replace view aggView3680792656017036848 as select v1, SUM(annot) as annot from aggJoin2321192459004253572 group by v1;
create or replace view aggJoin5765202871648461449 as select annot from Comment_replyOf_Message as Comment_replyOf_Message, aggView3680792656017036848 where Comment_replyOf_Message.ParentMessageId=aggView3680792656017036848.v1;
select SUM(annot) as v9 from aggJoin5765202871648461449;
