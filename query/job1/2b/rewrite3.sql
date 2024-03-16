create or replace view aggView3072688799604197007 as select id as v1 from company_name as cn where country_code= '[nl]';
create or replace view aggJoin6515976279368555025 as select movie_id as v12 from movie_companies as mc, aggView3072688799604197007 where mc.company_id=aggView3072688799604197007.v1;
create or replace view aggView6082031701690591210 as select v12 from aggJoin6515976279368555025 group by v12;
create or replace view aggJoin7311898124871070073 as select id as v12, title as v20 from title as t, aggView6082031701690591210 where t.id=aggView6082031701690591210.v12;
create or replace view aggView1838225447143520644 as select v12, MIN(v20) as v31 from aggJoin7311898124871070073 group by v12;
create or replace view aggJoin5791517429626679211 as select keyword_id as v18, v31 from movie_keyword as mk, aggView1838225447143520644 where mk.movie_id=aggView1838225447143520644.v12;
create or replace view aggView2775244994924574449 as select id as v18 from keyword as k where keyword= 'character-name-in-title';
create or replace view aggJoin7919379942349115965 as select v31 from aggJoin5791517429626679211 join aggView2775244994924574449 using(v18);
select MIN(v31) as v31 from aggJoin7919379942349115965;
