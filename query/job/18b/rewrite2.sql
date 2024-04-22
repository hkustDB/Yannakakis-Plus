create or replace view aggJoin8971938931396666267 as (
with aggView5724734728628508634 as (select id as v22 from name as n where gender= 'f')
select movie_id as v31, note as v5 from cast_info as ci, aggView5724734728628508634 where ci.person_id=aggView5724734728628508634.v22 and note IN ('(writer)','(head writer)','(written by)','(story)','(story editor)'));
create or replace view aggJoin5225212744946540543 as (
with aggView2685428937738158972 as (select id as v8 from info_type as it1 where info= 'genres')
select movie_id as v31, info as v15 from movie_info as mi, aggView2685428937738158972 where mi.info_type_id=aggView2685428937738158972.v8 and info IN ('Horror','Thriller'));
create or replace view aggView3617251368095331076 as select v15, v31 from aggJoin5225212744946540543 group by v15,v31;
create or replace view aggJoin1222885248247917654 as (
with aggView4714124842847264384 as (select v31 from aggJoin8971938931396666267 group by v31)
select id as v31, title as v32, production_year as v35 from title as t, aggView4714124842847264384 where t.id=aggView4714124842847264384.v31 and production_year>=2008 and production_year<=2014);
create or replace view aggView7625180673228538743 as select v32, v31 from aggJoin1222885248247917654 group by v32,v31;
create or replace view aggJoin7971097574300354633 as (
with aggView3259083172228897562 as (select id as v10 from info_type as it2 where info= 'rating')
select movie_id as v31, info as v20 from movie_info_idx as mi_idx, aggView3259083172228897562 where mi_idx.info_type_id=aggView3259083172228897562.v10 and info>'8.0');
create or replace view aggView3360646483727889757 as select v31, v20 from aggJoin7971097574300354633 group by v31,v20;
create or replace view aggJoin5046159827585350132 as (
with aggView2083903256431639701 as (select v31, MIN(v15) as v43 from aggView3617251368095331076 group by v31)
select v32, v31, v43 from aggView7625180673228538743 join aggView2083903256431639701 using(v31));
create or replace view aggJoin9150492854432024142 as (
with aggView1318911854413893730 as (select v31, MIN(v43) as v43, MIN(v32) as v45 from aggJoin5046159827585350132 group by v31,v43)
select v20, v43, v45 from aggView3360646483727889757 join aggView1318911854413893730 using(v31));
select MIN(v43) as v43,MIN(v20) as v44,MIN(v45) as v45 from aggJoin9150492854432024142;
