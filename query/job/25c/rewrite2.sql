create or replace view aggView4076600647887606372 as select id as v28, name as v29 from name as n where gender= 'm';
create or replace view aggView76278931094190376 as select id as v37, title as v38 from title as t;
create or replace view aggJoin860460223724626511 as (
with aggView4062818238674425420 as (select id as v10 from info_type as it2 where info= 'votes')
select movie_id as v37, info as v23 from movie_info_idx as mi_idx, aggView4062818238674425420 where mi_idx.info_type_id=aggView4062818238674425420.v10);
create or replace view aggJoin7944676227380654947 as (
with aggView8493590498115371398 as (select id as v8 from info_type as it1 where info= 'genres')
select movie_id as v37, info as v18 from movie_info as mi, aggView8493590498115371398 where mi.info_type_id=aggView8493590498115371398.v8);
create or replace view aggJoin4108314931106413062 as (
with aggView3313938813094417427 as (select v37, v18 from aggJoin7944676227380654947 group by v37,v18)
select v37, v18 from aggView3313938813094417427 where v18 IN ('Horror','Action','Sci-Fi','Thriller','Crime','War'));
create or replace view aggJoin793345472711841539 as (
with aggView2738273588665622761 as (select id as v12 from keyword as k where keyword IN ('murder','violence','blood','gore','death','female-nudity','hospital'))
select movie_id as v37 from movie_keyword as mk, aggView2738273588665622761 where mk.keyword_id=aggView2738273588665622761.v12);
create or replace view aggJoin3377077343462295976 as (
with aggView5799805624151698501 as (select v37 from aggJoin793345472711841539 group by v37)
select v37, v23 from aggJoin860460223724626511 join aggView5799805624151698501 using(v37));
create or replace view aggView6509727767908655551 as select v37, v23 from aggJoin3377077343462295976 group by v37,v23;
create or replace view aggJoin5394527619518271348 as (
with aggView455225397321737225 as (select v37, MIN(v18) as v49 from aggJoin4108314931106413062 group by v37)
select v37, v38, v49 from aggView76278931094190376 join aggView455225397321737225 using(v37));
create or replace view aggJoin3325627491371005246 as (
with aggView4549963411301625925 as (select v37, MIN(v49) as v49, MIN(v38) as v52 from aggJoin5394527619518271348 group by v37,v49)
select v37, v23, v49, v52 from aggView6509727767908655551 join aggView4549963411301625925 using(v37));
create or replace view aggJoin8717806251595502897 as (
with aggView581269613836068815 as (select v37, MIN(v49) as v49, MIN(v52) as v52, MIN(v23) as v50 from aggJoin3325627491371005246 group by v37,v49,v52)
select person_id as v28, note as v5, v49, v52, v50 from cast_info as ci, aggView581269613836068815 where ci.movie_id=aggView581269613836068815.v37 and note IN ('(writer)','(head writer)','(written by)','(story)','(story editor)'));
create or replace view aggJoin838576160620096464 as (
with aggView176150701634249997 as (select v28, MIN(v49) as v49, MIN(v52) as v52, MIN(v50) as v50 from aggJoin8717806251595502897 group by v28,v49,v50,v52)
select v29, v49, v52, v50 from aggView4076600647887606372 join aggView176150701634249997 using(v28));
select MIN(v49) as v49,MIN(v50) as v50,MIN(v29) as v51,MIN(v52) as v52 from aggJoin838576160620096464;
