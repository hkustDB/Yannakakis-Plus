create or replace view aggJoin7245828077185065618 as (
with aggView6683039879681189659 as (select id as v9, name as v59 from char_name as chn where ((name LIKE '%man%') OR (name LIKE '%Man%')))
select person_id as v38, movie_id as v47, v59 from cast_info as ci, aggView6683039879681189659 where ci.person_role_id=aggView6683039879681189659.v9);
create or replace view aggJoin3442585401761261812 as (
with aggView951857232059077646 as (select id as v38, name as v61 from name as n)
select v47, v59, v61 from aggJoin7245828077185065618 join aggView951857232059077646 using(v38));
create or replace view aggJoin4313989666926191277 as (
with aggView3752002399406204506 as (select id as v28 from kind_type as kt where kind= 'movie')
select id as v47, title as v48, production_year as v51 from title as t, aggView3752002399406204506 where t.kind_id=aggView3752002399406204506.v28 and production_year>2000);
create or replace view aggJoin2933748902305456462 as (
with aggView6864740393556825009 as (select id as v23 from info_type as it2 where info= 'rating')
select movie_id as v47, info as v33 from movie_info_idx as mi_idx, aggView6864740393556825009 where mi_idx.info_type_id=aggView6864740393556825009.v23 and info>'7.0');
create or replace view aggJoin6536553466857119565 as (
with aggView3636117249980973360 as (select v47, MIN(v33) as v60 from aggJoin2933748902305456462 group by v47)
select movie_id as v47, keyword_id as v25, v60 from movie_keyword as mk, aggView3636117249980973360 where mk.movie_id=aggView3636117249980973360.v47);
create or replace view aggJoin6938898566814017717 as (
with aggView4982003956830909859 as (select id as v5 from comp_cast_type as cct1 where kind= 'cast')
select movie_id as v47, status_id as v7 from complete_cast as cc, aggView4982003956830909859 where cc.subject_id=aggView4982003956830909859.v5);
create or replace view aggJoin8547731153123510959 as (
with aggView1486261687287996870 as (select id as v7 from comp_cast_type as cct2 where kind LIKE '%complete%')
select v47 from aggJoin6938898566814017717 join aggView1486261687287996870 using(v7));
create or replace view aggJoin6126419189820237122 as (
with aggView6328422687537910173 as (select id as v25 from keyword as k where keyword IN ('superhero','marvel-comics','based-on-comic','tv-special','fight','violence','magnet','web','claw','laser'))
select v47, v60 from aggJoin6536553466857119565 join aggView6328422687537910173 using(v25));
create or replace view aggJoin8113840622234468655 as (
with aggView9182106974186317441 as (select v47, MIN(v60) as v60 from aggJoin6126419189820237122 group by v47,v60)
select v47, v48, v51, v60 from aggJoin4313989666926191277 join aggView9182106974186317441 using(v47));
create or replace view aggJoin3423251732264995632 as (
with aggView3106030306867538558 as (select v47, MIN(v60) as v60, MIN(v48) as v62 from aggJoin8113840622234468655 group by v47,v60)
select v47, v60, v62 from aggJoin8547731153123510959 join aggView3106030306867538558 using(v47));
create or replace view aggJoin8911783166541357791 as (
with aggView7507099408211862737 as (select v47, MIN(v60) as v60, MIN(v62) as v62 from aggJoin3423251732264995632 group by v47,v60,v62)
select v59 as v59, v61 as v61, v60, v62 from aggJoin3442585401761261812 join aggView7507099408211862737 using(v47));
select MIN(v59) as v59,MIN(v60) as v60,MIN(v61) as v61,MIN(v62) as v62 from aggJoin8911783166541357791;
