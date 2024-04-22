create or replace view aggView5349786322508213684 as select title as v38, id as v37 from title as t;
create or replace view aggView4641526675435101624 as select id as v28, name as v29 from name as n where gender= 'm';
create or replace view aggJoin206325324004205306 as (
with aggView7939168538555320331 as (select id as v10 from info_type as it2 where info= 'votes')
select movie_id as v37, info as v23 from movie_info_idx as mi_idx, aggView7939168538555320331 where mi_idx.info_type_id=aggView7939168538555320331.v10);
create or replace view aggJoin4289976535051174372 as (
with aggView807086050316465475 as (select id as v8 from info_type as it1 where info= 'genres')
select movie_id as v37, info as v18 from movie_info as mi, aggView807086050316465475 where mi.info_type_id=aggView807086050316465475.v8);
create or replace view aggJoin6768258135572630859 as (
with aggView2781205657319996830 as (select v18, v37 from aggJoin4289976535051174372 group by v18,v37)
select v37, v18 from aggView2781205657319996830 where v18= 'Horror');
create or replace view aggJoin31645139749556304 as (
with aggView4466968828219309332 as (select id as v12 from keyword as k where keyword IN ('murder','blood','gore','death','female-nudity'))
select movie_id as v37 from movie_keyword as mk, aggView4466968828219309332 where mk.keyword_id=aggView4466968828219309332.v12);
create or replace view aggJoin4790663938740227495 as (
with aggView916453592590679909 as (select v37 from aggJoin31645139749556304 group by v37)
select v37, v23 from aggJoin206325324004205306 join aggView916453592590679909 using(v37));
create or replace view aggView1676121056496494707 as select v23, v37 from aggJoin4790663938740227495 group by v23,v37;
create or replace view aggJoin8665641356832600855 as (
with aggView8793151923611393906 as (select v37, MIN(v18) as v49 from aggJoin6768258135572630859 group by v37)
select v23, v37, v49 from aggView1676121056496494707 join aggView8793151923611393906 using(v37));
create or replace view aggJoin3038917577241963900 as (
with aggView2490246003820061505 as (select v37, MIN(v49) as v49, MIN(v23) as v50 from aggJoin8665641356832600855 group by v37,v49)
select v38, v37, v49, v50 from aggView5349786322508213684 join aggView2490246003820061505 using(v37));
create or replace view aggJoin9117454011037331532 as (
with aggView1187443708822836720 as (select v28, MIN(v29) as v51 from aggView4641526675435101624 group by v28)
select movie_id as v37, note as v5, v51 from cast_info as ci, aggView1187443708822836720 where ci.person_id=aggView1187443708822836720.v28 and note IN ('(writer)','(head writer)','(written by)','(story)','(story editor)'));
create or replace view aggJoin8881050730531378687 as (
with aggView2110647234695953879 as (select v37, MIN(v51) as v51 from aggJoin9117454011037331532 group by v37,v51)
select v38, v49 as v49, v50 as v50, v51 from aggJoin3038917577241963900 join aggView2110647234695953879 using(v37));
select MIN(v49) as v49,MIN(v50) as v50,MIN(v51) as v51,MIN(v38) as v52 from aggJoin8881050730531378687;
