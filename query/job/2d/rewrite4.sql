create or replace view aggView2139257494421504108 as select id as v12, title as v31 from title as t;
create or replace view aggJoin880932605406261282 as select movie_id as v12, keyword_id as v18, v31 from movie_keyword as mk, aggView2139257494421504108 where mk.movie_id=aggView2139257494421504108.v12;
create or replace view aggView6855925836065168700 as select id as v1 from company_name as cn where country_code= '[us]';
create or replace view aggJoin8763865703807148104 as select movie_id as v12 from movie_companies as mc, aggView6855925836065168700 where mc.company_id=aggView6855925836065168700.v1;
create or replace view aggView4529789471919769675 as select v12 from aggJoin8763865703807148104 group by v12;
create or replace view aggJoin6083408764158568353 as select v18, v31 as v31 from aggJoin880932605406261282 join aggView4529789471919769675 using(v12);
create or replace view aggView334798102742359433 as select v18, MIN(v31) as v31 from aggJoin6083408764158568353 group by v18;
create or replace view aggJoin8011875761728435628 as select keyword as v9, v31 from keyword as k, aggView334798102742359433 where k.id=aggView334798102742359433.v18 and keyword= 'character-name-in-title';
select MIN(v31) as v31 from aggJoin8011875761728435628;
