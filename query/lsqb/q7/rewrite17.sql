create or replace view aggView7811553706494974575 as select ParentMessageId as v1, COUNT(*) as annot from Comment_replyOf_Message as Comment_replyOf_Message group by ParentMessageId;
create or replace view aggJoin7567380278999563332 as select MessageId as v1, annot from Message_hasCreator_Person as Message_hasCreator_Person, aggView7811553706494974575 where Message_hasCreator_Person.MessageId=aggView7811553706494974575.v1;
create or replace view aggView7905420433185338367 as select v1, SUM(annot) as annot from aggJoin7567380278999563332 group by v1;
create or replace view aggJoin512845192338369067 as select MessageId as v1, annot from Person_likes_Message as Person_likes_Message, aggView7905420433185338367 where Person_likes_Message.MessageId=aggView7905420433185338367.v1;
create or replace view aggView2468009799319620717 as select v1, SUM(annot) as annot from aggJoin512845192338369067 group by v1;
create or replace view aggJoin1349298860222627285 as select annot from Message_hasTag_Tag as Message_hasTag_Tag, aggView2468009799319620717 where Message_hasTag_Tag.MessageId=aggView2468009799319620717.v1;
select SUM(annot) as v9 from aggJoin1349298860222627285;
