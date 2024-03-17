create or replace view aggView1150228545266147651 as select id as v14, name as v36 from name as n where name LIKE '%Downey%Robert%';
create or replace view aggJoin8209480254343805535 as select movie_id as v23, v36 from cast_info as ci, aggView1150228545266147651 where ci.person_id=aggView1150228545266147651.v14;
create or replace view aggView1724545671487699800 as select id as v8, keyword as v35 from keyword as k where keyword IN ('superhero','sequel','second-part','marvel-comics','based-on-comic','tv-special','fight','violence');
create or replace view aggJoin4330668302794110399 as select movie_id as v23, v35 from movie_keyword as mk, aggView1724545671487699800 where mk.keyword_id=aggView1724545671487699800.v8;
create or replace view aggView8199856032791059265 as select v23, MIN(v36) as v36 from aggJoin8209480254343805535 group by v23;
create or replace view aggJoin8773264678184818845 as select id as v23, title as v24, v36 from title as t, aggView8199856032791059265 where t.id=aggView8199856032791059265.v23 and production_year>2014;
create or replace view aggView2696796115265280322 as select v23, MIN(v36) as v36, MIN(v24) as v37 from aggJoin8773264678184818845 group by v23;
create or replace view aggJoin789254243291016052 as select v35 as v35, v36, v37 from aggJoin4330668302794110399 join aggView2696796115265280322 using(v23);
select MIN(v35) as v35,MIN(v36) as v36,MIN(v37) as v37 from aggJoin789254243291016052;
