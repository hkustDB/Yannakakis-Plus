create or replace view aggView4480741569295916863 as select id as v12, title as v31 from title as t;
create or replace view aggJoin1097931692140731699 as select movie_id as v12, company_id as v1, v31 from movie_companies as mc, aggView4480741569295916863 where mc.movie_id=aggView4480741569295916863.v12;
create or replace view aggView5945488917750113794 as select id as v1 from company_name as cn where country_code= '[de]';
create or replace view aggJoin8290343565084525428 as select v12, v31 from aggJoin1097931692140731699 join aggView5945488917750113794 using(v1);
create or replace view aggView1233533699497996574 as select v12, MIN(v31) as v31 from aggJoin8290343565084525428 group by v12;
create or replace view aggJoin8978007270906740916 as select keyword_id as v18, v31 from movie_keyword as mk, aggView1233533699497996574 where mk.movie_id=aggView1233533699497996574.v12;
create or replace view aggView7633523631988177835 as select id as v18 from keyword as k where keyword= 'character-name-in-title';
create or replace view aggJoin5863528700077079474 as select v31 from aggJoin8978007270906740916 join aggView7633523631988177835 using(v18);
select MIN(v31) as v31 from aggJoin5863528700077079474;
