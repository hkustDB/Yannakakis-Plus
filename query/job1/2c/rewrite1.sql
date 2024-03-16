create or replace view aggView8343870775987688318 as select id as v1 from company_name as cn where country_code= '[sm]';
create or replace view aggJoin3539206981842077697 as select movie_id as v12 from movie_companies as mc, aggView8343870775987688318 where mc.company_id=aggView8343870775987688318.v1;
create or replace view aggView2435730178617412892 as select v12 from aggJoin3539206981842077697 group by v12;
create or replace view aggJoin5134022537752521974 as select id as v12, title as v20 from title as t, aggView2435730178617412892 where t.id=aggView2435730178617412892.v12;
create or replace view aggView660245942001685909 as select v12, MIN(v20) as v31 from aggJoin5134022537752521974 group by v12;
create or replace view aggJoin1571690254345486980 as select keyword_id as v18, v31 from movie_keyword as mk, aggView660245942001685909 where mk.movie_id=aggView660245942001685909.v12;
create or replace view aggView7973343783117959892 as select v18, MIN(v31) as v31 from aggJoin1571690254345486980 group by v18;
create or replace view aggJoin4561283224937716891 as select keyword as v9, v31 from keyword as k, aggView7973343783117959892 where k.id=aggView7973343783117959892.v18 and keyword= 'character-name-in-title';
select MIN(v31) as v31 from aggJoin4561283224937716891;
