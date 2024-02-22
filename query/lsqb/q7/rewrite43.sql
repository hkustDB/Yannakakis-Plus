create or replace view aggView7264616412067742658 as select ParentMessageId as v1, COUNT(*) as annot from Comment_replyOf_Message as Comment_replyOf_Message group by ParentMessageId;
create or replace view aggJoin7660831426715462430 as select MessageId as v1, annot from Person_likes_Message as Person_likes_Message, aggView7264616412067742658 where Person_likes_Message.MessageId=aggView7264616412067742658.v1;
create or replace view aggView8331504639131020759 as select v1, SUM(annot) as annot from aggJoin7660831426715462430 group by v1;
create or replace view aggJoin1048624821478633070 as select MessageId as v1, annot from Message_hasTag_Tag as Message_hasTag_Tag, aggView8331504639131020759 where Message_hasTag_Tag.MessageId=aggView8331504639131020759.v1;
create or replace view aggView8038094518290640462 as select v1, SUM(annot) as annot from aggJoin1048624821478633070 group by v1;
create or replace view aggJoin6760115092410279220 as select annot from Message_hasCreator_Person as Message_hasCreator_Person, aggView8038094518290640462 where Message_hasCreator_Person.MessageId=aggView8038094518290640462.v1;
select SUM(annot) as v9 from aggJoin6760115092410279220;
