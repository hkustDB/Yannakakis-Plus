create or replace view aggView5630512338859351969 as select id as v1 from company_name as cn where country_code= '[nl]';
create or replace view aggJoin6146008137160571562 as select movie_id as v12 from movie_companies as mc, aggView5630512338859351969 where mc.company_id=aggView5630512338859351969.v1;
create or replace view aggView9010650630665019264 as select v12 from aggJoin6146008137160571562 group by v12;
create or replace view aggJoin8945303001069848410 as select id as v12, title as v20 from title as t, aggView9010650630665019264 where t.id=aggView9010650630665019264.v12;
create or replace view aggView7180114414249297763 as select v12, MIN(v20) as v31 from aggJoin8945303001069848410 group by v12;
create or replace view aggJoin1879843118375960022 as select keyword_id as v18, v31 from movie_keyword as mk, aggView7180114414249297763 where mk.movie_id=aggView7180114414249297763.v12;
create or replace view aggView6918391811588181550 as select id as v18 from keyword as k where keyword= 'character-name-in-title';
create or replace view aggJoin7372328008628119215 as select v31 from aggJoin1879843118375960022 join aggView6918391811588181550 using(v18);
select MIN(v31) as v31 from aggJoin7372328008628119215;
