create or replace view aggView3959325419545566998 as select id as v1 from company_name as cn where country_code= '[nl]';
create or replace view aggJoin6242017428543841546 as select movie_id as v12 from movie_companies as mc, aggView3959325419545566998 where mc.company_id=aggView3959325419545566998.v1;
create or replace view aggView7529591586076689547 as select v12 from aggJoin6242017428543841546 group by v12;
create or replace view aggJoin961411373254028024 as select id as v12, title as v20 from title as t, aggView7529591586076689547 where t.id=aggView7529591586076689547.v12;
create or replace view aggView169994598122768470 as select v12, MIN(v20) as v31 from aggJoin961411373254028024 group by v12;
create or replace view aggJoin5462474575471057276 as select keyword_id as v18, v31 from movie_keyword as mk, aggView169994598122768470 where mk.movie_id=aggView169994598122768470.v12;
create or replace view aggView3528137021214975198 as select v18, MIN(v31) as v31 from aggJoin5462474575471057276 group by v18;
create or replace view aggJoin6170489615125105444 as select keyword as v9, v31 from keyword as k, aggView3528137021214975198 where k.id=aggView3528137021214975198.v18 and keyword= 'character-name-in-title';
select MIN(v31) as v31 from aggJoin6170489615125105444;
