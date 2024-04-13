create or replace view aggView5378756191888135382 as select id as v12, title as v31 from title as t;
create or replace view aggJoin4189483154400645328 as select movie_id as v12, keyword_id as v18, v31 from movie_keyword as mk, aggView5378756191888135382 where mk.movie_id=aggView5378756191888135382.v12;
create or replace view aggView3929088894849624550 as select id as v1 from company_name as cn where country_code= '[us]';
create or replace view aggJoin593752784826652018 as select movie_id as v12 from movie_companies as mc, aggView3929088894849624550 where mc.company_id=aggView3929088894849624550.v1;
create or replace view aggView2653200773313717700 as select v12 from aggJoin593752784826652018 group by v12;
create or replace view aggJoin2076549833387114425 as select v18, v31 as v31 from aggJoin4189483154400645328 join aggView2653200773313717700 using(v12);
create or replace view aggView7906195259345974026 as select id as v18 from keyword as k where keyword= 'character-name-in-title';
create or replace view aggJoin6596578692442799938 as select v31 from aggJoin2076549833387114425 join aggView7906195259345974026 using(v18);
select MIN(v31) as v31 from aggJoin6596578692442799938;
