create or replace view aggView3732995099597681980 as select id as v18 from keyword as k where keyword= 'character-name-in-title';
create or replace view aggJoin8851273095748515146 as select movie_id as v12 from movie_keyword as mk, aggView3732995099597681980 where mk.keyword_id=aggView3732995099597681980.v18;
create or replace view aggView7660643154935268182 as select v12 from aggJoin8851273095748515146 group by v12;
create or replace view aggJoin3806430217679037520 as select id as v12, title as v20 from title as t, aggView7660643154935268182 where t.id=aggView7660643154935268182.v12;
create or replace view aggView3929710286349842004 as select id as v1 from company_name as cn where country_code= '[us]';
create or replace view aggJoin3840851683490616739 as select movie_id as v12 from movie_companies as mc, aggView3929710286349842004 where mc.company_id=aggView3929710286349842004.v1;
create or replace view aggView8864464193153653081 as select v12 from aggJoin3840851683490616739 group by v12;
create or replace view aggJoin4942980425929940411 as select v20 from aggJoin3806430217679037520 join aggView8864464193153653081 using(v12);
select MIN(v20) as v31 from aggJoin4942980425929940411;
