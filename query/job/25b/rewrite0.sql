create or replace view aggView19392168968089020 as select id as v28, name as v29 from name as n where gender= 'm';
create or replace view aggJoin2929770522901611277 as (
with aggView6801350012084895078 as (select title as v38, id as v37 from title as t where production_year>2010)
select v37, v38 from aggView6801350012084895078 where v38 LIKE 'Vampire%');
create or replace view aggJoin4609668832717777735 as (
with aggView7170575438863584002 as (select id as v8 from info_type as it1 where info= 'genres')
select movie_id as v37, info as v18 from movie_info as mi, aggView7170575438863584002 where mi.info_type_id=aggView7170575438863584002.v8 and info= 'Horror');
create or replace view aggView8279784858110857718 as select v18, v37 from aggJoin4609668832717777735 group by v18,v37;
create or replace view aggJoin4615499756394100670 as (
with aggView5486705704209738990 as (select id as v12 from keyword as k where keyword IN ('murder','blood','gore','death','female-nudity'))
select movie_id as v37 from movie_keyword as mk, aggView5486705704209738990 where mk.keyword_id=aggView5486705704209738990.v12);
create or replace view aggJoin5694480907757626387 as (
with aggView8441658348858767784 as (select id as v10 from info_type as it2 where info= 'votes')
select movie_id as v37, info as v23 from movie_info_idx as mi_idx, aggView8441658348858767784 where mi_idx.info_type_id=aggView8441658348858767784.v10);
create or replace view aggJoin3821486811472478833 as (
with aggView4677569017035067674 as (select v37 from aggJoin4615499756394100670 group by v37)
select v37, v23 from aggJoin5694480907757626387 join aggView4677569017035067674 using(v37));
create or replace view aggView8132676393353916917 as select v23, v37 from aggJoin3821486811472478833 group by v23,v37;
create or replace view aggJoin6325203822274457891 as (
with aggView3833256009764455467 as (select v37, MIN(v38) as v52 from aggJoin2929770522901611277 group by v37)
select v23, v37, v52 from aggView8132676393353916917 join aggView3833256009764455467 using(v37));
create or replace view aggJoin7079994422587580331 as (
with aggView3729513035549634777 as (select v37, MIN(v18) as v49 from aggView8279784858110857718 group by v37)
select person_id as v28, movie_id as v37, note as v5, v49 from cast_info as ci, aggView3729513035549634777 where ci.movie_id=aggView3729513035549634777.v37 and note IN ('(writer)','(head writer)','(written by)','(story)','(story editor)'));
create or replace view aggJoin7413111621084089910 as (
with aggView5732490092508630820 as (select v37, MIN(v52) as v52, MIN(v23) as v50 from aggJoin6325203822274457891 group by v37,v52)
select v28, v5, v49 as v49, v52, v50 from aggJoin7079994422587580331 join aggView5732490092508630820 using(v37));
create or replace view aggJoin2121048518914089004 as (
with aggView2655377038300889833 as (select v28, MIN(v49) as v49, MIN(v52) as v52, MIN(v50) as v50 from aggJoin7413111621084089910 group by v28,v50,v52,v49)
select v29, v49, v52, v50 from aggView19392168968089020 join aggView2655377038300889833 using(v28));
select MIN(v49) as v49,MIN(v50) as v50,MIN(v29) as v51,MIN(v52) as v52 from aggJoin2121048518914089004;
