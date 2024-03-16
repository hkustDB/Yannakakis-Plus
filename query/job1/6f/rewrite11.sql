create or replace view aggView2861932321016358384 as select id as v14, name as v36 from name as n;
create or replace view aggJoin2273877144661669281 as select movie_id as v23, v36 from cast_info as ci, aggView2861932321016358384 where ci.person_id=aggView2861932321016358384.v14;
create or replace view aggView8737692946436135164 as select id as v23, title as v37 from title as t where production_year>2000;
create or replace view aggJoin5997968794488578725 as select movie_id as v23, keyword_id as v8, v37 from movie_keyword as mk, aggView8737692946436135164 where mk.movie_id=aggView8737692946436135164.v23;
create or replace view aggView354216279977426752 as select v23, MIN(v36) as v36 from aggJoin2273877144661669281 group by v23;
create or replace view aggJoin3816006880631203573 as select v8, v37 as v37, v36 from aggJoin5997968794488578725 join aggView354216279977426752 using(v23);
create or replace view aggView2876566994319598713 as select v8, MIN(v37) as v37, MIN(v36) as v36 from aggJoin3816006880631203573 group by v8;
create or replace view aggJoin4802881416308938289 as select keyword as v9, v37, v36 from keyword as k, aggView2876566994319598713 where k.id=aggView2876566994319598713.v8 and keyword IN ('superhero','sequel','second-part','marvel-comics','based-on-comic','tv-special','fight','violence');
select MIN(v9) as v35,MIN(v36) as v36,MIN(v37) as v37 from aggJoin4802881416308938289;
