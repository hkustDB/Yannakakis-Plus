create or replace view aggJoin8341244748466724875 as (
with aggView8404801457009855891 as (select id as v37, title as v52 from title as t where production_year>2010 and title LIKE 'Vampire%')
select movie_id as v37, info_type_id as v8, info as v18, v52 from movie_info as mi, aggView8404801457009855891 where mi.movie_id=aggView8404801457009855891.v37 and info= 'Horror');
create or replace view aggJoin9077155656177017834 as (
with aggView937654378939975738 as (select id as v28, name as v51 from name as n where gender= 'm')
select movie_id as v37, note as v5, v51 from cast_info as ci, aggView937654378939975738 where ci.person_id=aggView937654378939975738.v28 and note IN ('(writer)','(head writer)','(written by)','(story)','(story editor)'));
create or replace view aggJoin7784068303409385547 as (
with aggView6011183996649405830 as (select id as v8 from info_type as it1 where info= 'genres')
select v37, v18, v52 from aggJoin8341244748466724875 join aggView6011183996649405830 using(v8));
create or replace view aggJoin5930055321124131410 as (
with aggView5413191477826346298 as (select v37, MIN(v52) as v52, MIN(v18) as v49 from aggJoin7784068303409385547 group by v37,v52)
select movie_id as v37, keyword_id as v12, v52, v49 from movie_keyword as mk, aggView5413191477826346298 where mk.movie_id=aggView5413191477826346298.v37);
create or replace view aggJoin8547048918138690419 as (
with aggView941800780359075761 as (select id as v12 from keyword as k where keyword IN ('murder','blood','gore','death','female-nudity'))
select v37, v52, v49 from aggJoin5930055321124131410 join aggView941800780359075761 using(v12));
create or replace view aggJoin1762406318581401649 as (
with aggView1412300487844768580 as (select id as v10 from info_type as it2 where info= 'votes')
select movie_id as v37, info as v23 from movie_info_idx as mi_idx, aggView1412300487844768580 where mi_idx.info_type_id=aggView1412300487844768580.v10);
create or replace view aggJoin5543907229444667712 as (
with aggView125416225778387670 as (select v37, MIN(v23) as v50 from aggJoin1762406318581401649 group by v37)
select v37, v5, v51 as v51, v50 from aggJoin9077155656177017834 join aggView125416225778387670 using(v37));
create or replace view aggJoin7961426254660643994 as (
with aggView7979464739905566725 as (select v37, MIN(v51) as v51, MIN(v50) as v50 from aggJoin5543907229444667712 group by v37,v50,v51)
select v52 as v52, v49 as v49, v51, v50 from aggJoin8547048918138690419 join aggView7979464739905566725 using(v37));
select MIN(v49) as v49,MIN(v50) as v50,MIN(v51) as v51,MIN(v52) as v52 from aggJoin7961426254660643994;
