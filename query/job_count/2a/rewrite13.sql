create or replace view aggView417527265661389051 as select id as v1 from company_name as cn where country_code= '[de]';
create or replace view aggJoin6036976638388712014 as select movie_id as v12 from movie_companies as mc, aggView417527265661389051 where mc.company_id=aggView417527265661389051.v1;
create or replace view aggView5169218289757411735 as select v12, COUNT(*) as annot from aggJoin6036976638388712014 group by v12;
create or replace view aggJoin8913616501722515612 as select id as v12, annot from title as t, aggView5169218289757411735 where t.id=aggView5169218289757411735.v12;
create or replace view aggView2166021980612574190 as select v12, SUM(annot) as annot from aggJoin8913616501722515612 group by v12;
create or replace view aggJoin2973916261140085435 as select keyword_id as v18, annot from movie_keyword as mk, aggView2166021980612574190 where mk.movie_id=aggView2166021980612574190.v12;
create or replace view aggView3764474525932003740 as select id as v18 from keyword as k where keyword= 'character-name-in-title';
create or replace view aggJoin4654419498012262100 as select annot from aggJoin2973916261140085435 join aggView3764474525932003740 using(v18);
select SUM(annot) as v31 from aggJoin4654419498012262100;
