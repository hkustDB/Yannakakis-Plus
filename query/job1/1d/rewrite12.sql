create or replace view aggView3064351679952849185 as select id as v15, title as v28, production_year as v29 from title as t where production_year>2000;
create or replace view aggJoin4982350609505811930 as select movie_id as v15, info_type_id as v3, v28, v29 from movie_info_idx as mi_idx, aggView3064351679952849185 where mi_idx.movie_id=aggView3064351679952849185.v15;
create or replace view aggView3075640540392206872 as select id as v1 from company_type as ct where kind= 'production companies';
create or replace view aggJoin3300439692912059704 as select movie_id as v15, note as v9 from movie_companies as mc, aggView3075640540392206872 where mc.company_type_id=aggView3075640540392206872.v1 and note NOT LIKE '%(as Metro-Goldwyn-Mayer Pictures)%';
create or replace view aggView7730637381214326753 as select v15, MIN(v9) as v27 from aggJoin3300439692912059704 group by v15;
create or replace view aggJoin3874208459409378508 as select v3, v28 as v28, v29 as v29, v27 from aggJoin4982350609505811930 join aggView7730637381214326753 using(v15);
create or replace view aggView6431073204811754354 as select id as v3 from info_type as it where info= 'bottom 10 rank';
create or replace view aggJoin3624463631766190624 as select v28, v29, v27 from aggJoin3874208459409378508 join aggView6431073204811754354 using(v3);
select MIN(v27) as v27,MIN(v28) as v28,MIN(v29) as v29 from aggJoin3624463631766190624;
