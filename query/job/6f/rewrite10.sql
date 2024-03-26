create or replace view aggView1486918183030703687 as select id as v8, keyword as v35 from keyword as k where keyword IN ('superhero','sequel','second-part','marvel-comics','based-on-comic','tv-special','fight','violence');
create or replace view aggJoin6677489298065345955 as select movie_id as v23, v35 from movie_keyword as mk, aggView1486918183030703687 where mk.keyword_id=aggView1486918183030703687.v8;
create or replace view aggView497715174116990749 as select id as v23, title as v37 from title as t where production_year>2000;
create or replace view aggJoin7199099404230965750 as select v23, v35, v37 from aggJoin6677489298065345955 join aggView497715174116990749 using(v23);
create or replace view aggView486819398401574587 as select id as v14, name as v36 from name as n;
create or replace view aggJoin5606984032023127228 as select movie_id as v23, v36 from cast_info as ci, aggView486819398401574587 where ci.person_id=aggView486819398401574587.v14;
create or replace view aggView2643698310408464075 as select v23, MIN(v35) as v35, MIN(v37) as v37 from aggJoin7199099404230965750 group by v23;
create or replace view aggJoin1352003366124854658 as select v36 as v36, v35, v37 from aggJoin5606984032023127228 join aggView2643698310408464075 using(v23);
select MIN(v35) as v35,MIN(v36) as v36,MIN(v37) as v37 from aggJoin1352003366124854658;
