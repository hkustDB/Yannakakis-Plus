create or replace view aggView3300543776851369023 as select id as v12, title as v31 from title as t;
create or replace view aggJoin5740467010036196272 as select movie_id as v12, keyword_id as v18, v31 from movie_keyword as mk, aggView3300543776851369023 where mk.movie_id=aggView3300543776851369023.v12;
create or replace view aggView1880586572957308032 as select id as v1 from company_name as cn where country_code= '[de]';
create or replace view aggJoin5330505211936358062 as select movie_id as v12 from movie_companies as mc, aggView1880586572957308032 where mc.company_id=aggView1880586572957308032.v1;
create or replace view aggView7586029141639892574 as select v12 from aggJoin5330505211936358062 group by v12;
create or replace view aggJoin5750703278374598641 as select v18, v31 as v31 from aggJoin5740467010036196272 join aggView7586029141639892574 using(v12);
create or replace view aggView6842271114536225807 as select id as v18 from keyword as k where keyword= 'character-name-in-title';
create or replace view aggJoin562585802335032171 as select v31 from aggJoin5750703278374598641 join aggView6842271114536225807 using(v18);
select MIN(v31) as v31 from aggJoin562585802335032171;
