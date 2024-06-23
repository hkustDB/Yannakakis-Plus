create or replace view aggView3920363287920792866 as select id as v8, keyword as v35 from keyword as k where keyword IN ('superhero','sequel','second-part','marvel-comics','based-on-comic','tv-special','fight','violence');
create or replace view aggJoin6600270858957332885 as select movie_id as v23, v35 from movie_keyword as mk, aggView3920363287920792866 where mk.keyword_id=aggView3920363287920792866.v8;
create or replace view aggView8771800556580406335 as select id as v14, name as v36 from name as n where name LIKE '%Downey%Robert%';
create or replace view aggJoin3017909984368810373 as select movie_id as v23, v36 from cast_info as ci, aggView8771800556580406335 where ci.person_id=aggView8771800556580406335.v14;
create or replace view aggView3486311931348441175 as select v23, MIN(v35) as v35 from aggJoin6600270858957332885 group by v23;
create or replace view aggJoin2969725261396136168 as select id as v23, title as v24, production_year as v27, v35 from title as t, aggView3486311931348441175 where t.id=aggView3486311931348441175.v23 and production_year>2000;
create or replace view aggView7388867489384150305 as select v23, MIN(v36) as v36 from aggJoin3017909984368810373 group by v23;
create or replace view aggJoin4550649536122319605 as select v24, v27, v35 as v35, v36 from aggJoin2969725261396136168 join aggView7388867489384150305 using(v23);
select MIN(v35) as v35,MIN(v36) as v36,MIN(v24) as v37 from aggJoin4550649536122319605;
