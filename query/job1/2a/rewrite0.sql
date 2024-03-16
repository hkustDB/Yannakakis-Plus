create or replace view aggView5965748770005120661 as select id as v1 from company_name as cn where country_code= '[de]';
create or replace view aggJoin2582560599616174425 as select movie_id as v12 from movie_companies as mc, aggView5965748770005120661 where mc.company_id=aggView5965748770005120661.v1;
create or replace view aggView7753829649046862624 as select v12 from aggJoin2582560599616174425 group by v12;
create or replace view aggJoin8479948226644766548 as select id as v12, title as v20 from title as t, aggView7753829649046862624 where t.id=aggView7753829649046862624.v12;
create or replace view aggView177014671015767302 as select v12, MIN(v20) as v31 from aggJoin8479948226644766548 group by v12;
create or replace view aggJoin2765789255403255416 as select keyword_id as v18, v31 from movie_keyword as mk, aggView177014671015767302 where mk.movie_id=aggView177014671015767302.v12;
create or replace view aggView7019368444216112892 as select v18, MIN(v31) as v31 from aggJoin2765789255403255416 group by v18;
create or replace view aggJoin6231852476692685364 as select keyword as v9, v31 from keyword as k, aggView7019368444216112892 where k.id=aggView7019368444216112892.v18 and keyword= 'character-name-in-title';
select MIN(v31) as v31 from aggJoin6231852476692685364;
